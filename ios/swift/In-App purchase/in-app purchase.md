# How to implement In-App purchase

 - **Setup in app purchase in app store connect**
 - **Creating In-App Purchase Products**
 - **Enable in xcode project**
 - **Consumables**
 - **Non-consubable**
 - **Non renewing subscriptions**
 - **Auto renewing subscriptions**
 - **Testing**
 - **FAQ**

An _in-app purchase_ (or _IAP_) allows developers to charge users for specific functionality or content while using an app.


## Setup in app purchase in app store connect
First, you need to create an App ID. This will link together your app to your in-app purchaseable products. Login to the Apple Developer Center, then select _Certificates, IDs & Profiles_.

![enter image description here](https://bitbucket.org/elegantmedia/em-knowledge-base/src/master/ios/swift/In-App%20purchase/images/1.png)

Next, select _Identifiers > App IDs_, and click _+_ in the upper right corner to create a new App ID.

![enter image description here](https://bitbucket.org/elegantmedia/em-knowledge-base/src/master/ios/swift/In-App%20purchase/images/2.png)

Fill out the information for the new App ID. Enter  the app name Choose  _Explicit App ID_  and enter a unique  _Bundle ID_. A common practice is to use your domain name in reverse. Make note of the Bundle ID as it will be needed in the steps that follow.

Scroll down to the  _App Services_  section. Notice that  _In-App Purchase_ and  _GameCenter_ are enabled by default. Click  _Continue_  and then  _Register_  and  _Done_.

![enter image description here](https://bitbucket.org/elegantmedia/em-knowledge-base/src/master/ios/swift/In-App%20purchase/images/3.png)



### Creating an App in iTunes Connect

Now to create the app record itself, click _App Store Connect_  in the upper left corner of the page, then click _My Apps_.

Next, click _+_ in the upper left corner of the page and select _New App_ to add a new app record. Fill out the information as shown here:

![enter image description here](https://bitbucket.org/elegantmedia/em-knowledge-base/src/master/ios/swift/In-App%20purchase/images/1.png)


Fill out the information as above.

    Note: If you are quick in getting to this step, the Bundle ID might not be showing up in the dropdown list. This sometimes takes a while to propagate through Apple’s systems.

## Creating In-App Purchase Products
There are a whole bunch of different types of IAP you can add:

-   _Consumable_: These can be bought more than once and can be used up. These are a good fit for extra lives, in-game currency, temporary power-ups, and the like.
-   _Non-Consumable_: Something that you buy once, and expect to have permanently such as extra levels and unlockable content. The RazeFace illustrations from this tutorial fall into this category.
-   _Non-Renewing Subscription_: Content that’s available for a fixed period of time.
-   _Auto-Renewing Subscription_: A repeating subscription such as a monthly

You can only offer In-App Purchases for digital items, and not for physical goods or services. For more information about all of this, check out Apple’s full documentation on [Creating In-App Purchase Products](https://developer.apple.com/library/ios/documentation/LanguagesUtilities/Conceptual/iTunesConnectInAppPurchase_Guide/Chapters/CreatingInAppPurchaseProducts.html#//apple_ref/doc/uid/TP40013727-CH3-SW1).

Now, while viewing your app’s entry in App Store Connect, click on the _Features_ tab and then select _In-App Purchases_. To add a new IAP product, click the _+_ to the right of _In-App Purchases_.


You’ll see the following dialog appear:

When a user purchases a something in your app, you’ll want them to always have access to it, so select _Non-Consumable_, and click _Create_.

Next select the _Capabilities_ tab. Scroll down to _In-App Purchase_ and toggle the switch to _ON_.

## Enable in xcode project
For everything to work correctly, it’s really important that the bundle identifier and product identifiers in the app match the ones you just created in the Developer Center and in App Store Connect.

Head over to the starter project in Xcode. Select the    project in the Project navigator, then select it again under  _Targets_. Select the  _General_  tab, switch your  _Team_  to your correct team, and enter the bundle ID you used earlier


## Consumables

Next, fill out the details for the IAP as follows:

![enter image description here](https://bitbucket.org/elegantmedia/em-knowledge-base/src/master/ios/swift/In-App%20purchase/images/5.png)

-   _Reference Name_: A nickname identifying the IAP within iTunes Connect. This name does not appear anywhere in the app. The title of the App you’ll be unlocking with this purchase is  _Swift Shopping_, so enter that here.
-   _Product ID_: This is a unique string identifying the IAP. Usually it’s best to start with the Bundle ID and then append a unique name specific to this purchasable item.
-   _Cleared for Sale_: Enables or disables the sale of the IAP. You want to enable it!
-   _Price Tier_: The cost of the IAP. Choose  _Tier 1_.

Now scroll down to the _Localizations_ section and note that there is a default entry for English (U.S.). Enter “Swift Shopping” for both the _Display Name_ and the _Description_. Click _Save_.


_`Note_: App Store Connect may complain that you’re missing metadata for your IAP. Before you submit your app for review, you’re required to add a screenshot of the IAP at the bottom of this page. The screenshot is used _only_ for Apple’s review and does not appear in your App Store listing.`

## Testing
### Creating a Sandbox User

In App Store Connect, click  _App Store Connect_  in the top left corner of the window to get back to the main menu. Select _Users and Roles_, then click the  _Sandbox Testers_  tab. Click  _+_  next to the “Tester” title.


