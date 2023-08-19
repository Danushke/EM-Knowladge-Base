Develop An Apartment Rental Application With Oxygen - Part 3
===================================================

This is the third part of the **Apartment Rental Application (ARA)** tutorial. Please refer to the previous parts using the links below.

- [Develop An Apartment Rental Application With Oxygen - Part 1](../apartment-rental-oxygen-application-1.md)
- [Develop An Apartment Rental Application With Oxygen - Part 2](../apartment-rental-oxygen-application-2.md)

The development of the **admin panel** and the **API** is discussed in first two parts of this tutorial. In this part we discuss the **device data management** and **push notifications**.


## Device Athentication

The **API** is consumed by the mobile applications runing on mobile devices, usually the smart phones and tabs. Devices are authorized using an **access token**. It is generated when a user logs in to the mobile application. The **access token** is bound to a device instead of the user. Since a user can have multiple devices, the application has to manage the connection between the users and their devices to provide a seamless experience. The **Oxygen** utilizes `emedia/devices-laravel` package for this purpose.

In order to record the device details, the **register** and **login** APIs accept the following details:
- device_id
- device_type
- device_push_token

If you have generated the API documents as discussed in the **Part 2** of this tutorial, you can see these parameters ae mentioned with the respective API endpoint in API documentaion.

Please read the **README.MD** file of the [Devices - Laravel](https://bitbucket.org/elegantmedia/devices-laravel/src/master/) package for setup instructions.


## Push Notifications

A push notification is a message that pops up on a mobile device. App publishers can send them at any time; users don’t have to be in the app or using their devices to receive them. They can do a lot of things; for example, they can show the latest sports scores, get a user to take an action, such as downloading a coupon, or let a user know about an event, such as a flash sale.

Push notifications look like SMS text messages and mobile alerts, but they only reach users who have installed your app. Both **Android** and **iOS** have support for push notifications.

The **Oxygen** utilizes the [Oxygen Push Notifications](https://bitbucket.org/elegantmedia/oxygen-push-notifications/src/master/) package to send push notifications. It uses Firebase Cloud Messageing to send the push notifications.

Please read the **README.MD** file of the [Oxygen Push Notifications](https://bitbucket.org/elegantmedia/oxygen-push-notifications/src/master/README.md) package for setup instructions.

**Oxygen Push Notifications** package uses **Firebase Cloud Messaging (FCM)** to send push notifications. Please check the guides on **Firebase** to [learn more about FCM](https://firebase.google.com/products/cloud-messaging).

- [About FCM messages](https://firebase.google.com/docs/cloud-messaging/concept-options)
- [FCM Architectural Overview](https://firebase.google.com/docs/cloud-messaging/fcm-architecture)
- [Send messages to multiple devices](https://firebase.google.com/docs/cloud-messaging/android/send-multiple)

## Notify the apartment owner


The **Apartment Rental Application (ARA)** serves two kind of users.
- Apartment owners
- Tenants

As per the requirement, **apartment owner** should get a push notification on his mobile device when someone submits an inquery request. Let's see how we can send a push notification to the owner. Add following 2 classes to the top of the `InquiriesAPIController.php` file.

```php
use EMedia\OxygenPushNotifications\Domain\PushNotificationManager;
use EMedia\OxygenPushNotifications\Entities\PushNotifications\PushNotification;
```

And, add push notification seding code to `store()` method.

```php
protected function store(Request $request)
{
	document(function () {
      	return (new APICall())
      	    ->setParams([
      	        (new Param('apartment_id', 'Integer', 'ID of the apartment', 'body')),
      	        (new Param('message', 'String', 'Message to the apartment owner', 'body')),
              ])
              ->setSuccessObject(Inquiry::class);
      });

      $this->validate($request, [
          'apartment_id' => 'required|integer|exists:apartments,id',
          'message' => 'required',
      ]);

      $user = DeviceAuthenticator::getUserByAccessToken();
      $apartment = $this->apartmentsRepo->find($request->apartment_id, ['user']);

      $data = $request->only(['apartment_id', 'message']);
      $data['user_id'] = $user->id;
      $inquery = $this->repo->create($data);

      if ($inquery) {
          if (isset($apartment->user)) {
              // send push notification
              $push = new PushNotification([
                  'title' => 'New inquiry request',
                  'message' => 'You have recieved a new inquiry request',
              ]);
              $push->scheduled_at = now();
              $push->notifiable()->associate($apartment->user);
              $push->save();
              PushNotificationManager::sendStoredPushNotification($push);
          }
      }

	return response()->apiSuccess($inquery);
}
```

It creates a new **Push Notification** and associates it with a **user**. In this case the user is apartment owner. A user can have multiple devices registered under his/her account. In this case the push notification goes to all devices. Following method can be used to send only to a particular device.

```php
$push->notifiable()->associate($user->devices->first());
```

The **push notification** should be saved to the database before it can be sent to the recipients. The actual notificaiton is sent with the below line:

```php
PushNotificationManager::sendStoredPushNotification($push);
```

This sends the notificaiton immediately.


## Notify all users

All users of the application should be notified when a new appratment is added to the app. Sending notifications one by one will take a long time depending on the number of users having the application. Firebase provides [Topic Messaging](https://firebase.google.com/docs/cloud-messaging/js/topic-messaging) as a solution for this. You can create **topics** and subscribe many devices to a topic. Then you can send the push notifications by topic. Firebase will send such notifications to all the subscribers of the topic.

The **Oxygen Push Notifications** package comes with 3 default topics:

- all_devices
- ios_devices
- android_devices

We can subscribe users to these topics when they **register** or **login**. The `api/v1/register` and `api/v1/login` routes are handled by the `App\Http\Controllers\API\V1\Auth\AuthController` class. It extends the `EMedia\Oxygen\Http\Controllers\API\V1\Auth\AuthController` class. The actual logic related to **register** and **login** functions are in that class. In order to subscribe users when they **register** or **login**, we have to override their respective functions. Open the `vendow/emedia/oxygen/src/Http/Controllers/API/V1/Auth/AuthController.php` file and copy followinmg two functions to the `app/Http/Controllers/API/V1/Auth/AuthController.php` file.

```php
/**
 *
 * Register a user.
 *
 * You probably don't need to duplicate this function.
 * See the other functions and parameters which can be extended as required.
 *
 * @param Request $request
 * @return \Illuminate\Http\JsonResponse
 * @throws \Illuminate\Validation\ValidationException
 */
public function register(Request $request)
{
	document($this->getRegisterApiDocumentFunction());

	$this->validate($request, $this->getRegistrationValidationRules());

	$data = $request->only($this->fillable);
	$data['password'] = bcrypt($request->password);
	$user = $this->usersRepository->create($data);

	$responseData = $user->toArray();
	$deviceData = $request->only($this->fillableDeviceParams);
	$device = $this->devicesRepo->createOrUpdateByIDAndType($deviceData, $user->id);
	$responseData['access_token'] = $device->access_token;

	return response()->apiSuccess($responseData);
}


/**
 *
 * Login to the API and get access token
 *
 * @param Request $request
 *
 * @return \Illuminate\Http\JsonResponse
 * @throws \Illuminate\Validation\ValidationException
 */
public function login(Request $request)
{
	document(function () {
		return (new APICall())->setName('Login')
			->setParams([
				(new Param('device_id', Param::TYPE_STRING, 'Unique ID of the device'))
					->setVariable(PostmanVar::UUID),
				(new Param('device_type', Param::TYPE_STRING, 'Type of the device `APPLE` or `ANDROID`'))
					->setExample('apple'),
				(new Param(
					'device_push_token',
					Param::TYPE_STRING,
					'Unique push token for the device'
				))->optional(),

				(new Param('email'))->setExample('test@example.com')->setVariable('{{test_user_email}}'),
				(new Param('password'))->setVariable('{{login_user_pass}}'),
			])
			->setApiKeyHeader()
			->setSuccessObject(app('oxygen')->getUserClass())
			;
	});

	$this->validate($request, [
		'device_id' => 'required',
		'device_type' => 'required',
		'email' => 'required|email',
		'password' => 'required',
	]);

	if (!auth()->attempt($request->only('email', 'password'), true)) {
		return response()->apiErrorUnauthorized(trans('auth.api.login-failed'));
	}

	$user = auth()->user();
	$response = $user->toArray();
	$device = $this->devicesRepo->findByDeviceForUser($user->id, $request->get('device_id'));

	// return an existing device
	if ($device) {
		// reset the push token and access tokens
		// because someone else could be logging in from the same device
		if ($request->device_push_token && ($device->device_push_token !== $request->device_push_token)) {
			$device->device_push_token = $request->device_push_token;
		}
		$device->refreshAccessToken();
	} else {
		// if this is a new device, create it
		$device = $this->devicesRepo->createOrUpdateByIDAndType(
			$request->only('device_id', 'device_type', 'device_push_token'),
			$user->id
		);
	}

	$response['access_token'] = $device->access_token;

	return response()->apiSuccess($response);
}
```

Then add the following line to both functions right after the line that adds the `device` for user. This is the line that goes like `$device = $this->devicesRepo->createOrUpdateByIDAndType( . . . )`:

```php
\EMedia\OxygenPushNotifications\Domain\PushNotificationManager::subscribeDeviceToBroadcastTopics($device);
```

This will add the device to `all_devices` topic. Also it will add the device to one of the topics `ios_devices` or `android_devices` based on the type if the device. **iOS** devices are added to `ios_devices` topic and **Android** devices are added to `android_devices` topic.

Now let's send a notification to `all_devices` topic when somone adds a new apartemnt.

```php
protected function store(Request $request)
{
	document(function () {
      	return (new APICall())
      	    ->setParams([
                  (new Param('name', 'String', 'Name of the apartment', 'body')),
                  (new Param('description', 'String', 'Apartment description', 'body')),
      	        (new Param('city_id', 'Integer', 'ID of the city', 'body')),
              ])
              ->setSuccessObject(Inquiry::class);
      });

      $this->validate($request, [
          'name' => 'required',
          'description' => 'required',
          'city_id' => 'required|integer|exists:cities,id',
      ]);

      $user = DeviceAuthenticator::getUserByAccessToken();

      $data = $request->only(['name', 'description', 'city_id']);
      $data['user_id'] = $user->id;
	$apartment = $this->repo->create($data);

      if ($apartment) {
          if (isset($apartment->user)) {
              // send push notification
              $push = new PushNotification([
                  'title' => 'New apartment listed',
                  'message' => 'Check out this new apartment listed now',
              ]);
              $push->scheduled_at = now();
              $push->topic('all_devices');
              $push->save();
              PushNotificationManager::sendStoredPushNotification($push);
          }
      }

	return response()->apiSuccess($apartment);
}
```

Note that, instead of associating the notification with a user or a device, we add the topic `all_devices` to it. This way it will be sent to all the devices we registered to the topic `all_devices`.


## Subscribe to custom topics

You can add new topics additianally based on the requirement of the application. For example, if we need to notifiy users about the new apartments added in their city, we can create a topic with the city name. When a new apartment gets registered, we can send the notification to the relevant topic. However, using a name might not be a good idea if the name can be updated later. I suggest generating the **topic name** based on the **id** of the city (or any other entity you choose).

Assume, **user** object has a property `city_id` to associate it with a **city** object. At **register** or **login** we can add user devices to a new topic created for their city:

```php
$topic = 'city_' . $user->city_id;
\EMedia\OxygenPushNotifications\Domain\PushNotificationManager::subscribeDeviceToBroadcastTopics($device, $topic);
```

Then, send the notification to respective topic when a new apartment in a city is added:

```php
$push->topic('city_' . $apartment->city_id);
```

**Exercise 1**: Write the code to send push notifications to all users from a country when a new apartment is added in that country.


## Sending push notifications

Sending push notificaitons can be immediate or scheduled. We used the below method to send a push notification immediately:

```php
PushNotificationManager::sendStoredPushNotification($push);
```

To schedule to be sent at a later time you need to set the value of the `scheduled_at` property of a **push notificaiton**.

```php
$push->scheduled_at = \Carbon\Carbon::now()->addDays(1);
```

Scheduled notifications can be sent with the following artisan command:

```sh
php artisan oxygen:push-notifications-send
```

It will pick the push notifications scheduled to be sent at the moment it runs and send them out. In a live application this can be done automatically using a scheduled command.

Add following to the `schedule()` method of `app/Console/Kernel.php` to send push notifications at every minute:

```php
$schedule->command('oxygen:push-notifications-send')->everyMinute();
```

**Exercise 2**: Write the code to schedule the new apartment notification to go out after 10 minutes from creating it.
