   # Social Login Authentication Support

This document will discribe about API authentication via social networks (Facebook, Google) for Laravel backends. These backend APIs provide social network user verification service and user data saving part. 

### Steps
* Install and configure Laravel Socialite
* Create Social Network Apps
* Create APIs for verify user

### Install and configure Laravel Socialite

    [Socialite](https://laravel.com/docs/5.7/socialite) is laravel package that use to make authentication with social networks.  

```sh
$ composer require laravel/socialite
```

After the installtion to set up configurations for Socialite package we need to add service provider to the config/app.php file. and also upadte an alias array.

    'providers' => [
        Laravel\Socialite\SocialiteServiceProvider::class,
    ],

    'Socialite' => Laravel\Socialite\Facades\Socialite::class,

### Create Social Network Apps

    Ass the next step, need to create Social Network Apps and place the credentials in config/services.php file.

    [Google Developer Console](https://console.developers.google.com)
    [Facebook Developer Potal](https://developers.facebook.com/)

    'facebook' => [
        'app_id' => 'xxxxxxx',
        'app_secret' => 'xxxxxxxx',
    ],

    'google' => [
        'client_id' => 'xxxxxxx',
        'client_secret' => 'xxxxxxxx',
    ],

### Create APIs for verify user

    We can use Socialite package to verify Facebook Logged users using there access token. 

    $result = Socialite::driver('facebook')->userFromToken($token);

    While Google logged users are verified using google id_token.

    $client = new Google_Client(['client_id' => 'xxxxxxx']); 
    $result = $client->verifyIdToken($token);

### Resources

Followings resources will provide support for you, 

* [Laravel Socialite](https://laravel.com/docs/5.7/socialite) - Laravel Socialite Document
* [Google Sign-In for Android](https://developers.google.com/identity/sign-in/android/backend-auth) - Authenticate with a backend server
* [Hivokas](https://hivokas.com/api-authentication-via-social-networks-for-your-laravel-application) - API authentication via social networks for your Laravel application by Ilya Sakovich

Thank You!