# Prepare App for Release

## Publish your app

Publishing is the general process that makes your Android applications available to users. When you publish an Android application you perform two main tasks:

* You prepare the application for release.
  During the preparation step you build a release version of your application, which users can download and install on their Android-powered devices.

* You release the application to users.
  During the release step you publicize, sell, and distribute the release version of your application to users.
  
Preparing your application for release is a multi-step process that involves the following tasks:

* Configuring your application for release.
  At a minimum you need to remove Log calls and remove the android:debuggable attribute from your manifest file. You should also provide values for the android:versionCode and android:versionName attributes, which are located in the 'manifest' element. You may also have to configure several other settings to meet Google Play requirements or accommodate whatever method you're using to release your application.

If you are using Gradle build files, you can use the release build type to set your build settings for the published version of your app.

 * Building and signing a release version of your application.
   You can use the Gradle build files with the release build type to build and sign a release version of your application. See Building and Running from Android Studio.

* Testing the release version of your application.
* Before you distribute your application, you should thoroughly test the release version on at least one target handset device and one target tablet device.

* Updating application resources for release.
  You need to be sure that all application resources such as multimedia files and graphics are updated and included with your application or staged on the proper production servers.

* Preparing remote servers and services that your application depends on.
  If your application depends on external servers or services, you need to be sure they are secure and production ready.
  
 
You may have to perform several other tasks as part of the preparation process. For example, you will need to get a private key for signing your application. You will also need to create an icon for your application, and you may want to prepare an End User License Agreement (EULA) to protect your person, organization, and intellectual property.

When you are finished preparing your application for release you will have a signed .apk file that you can distribute to users.
  
### Releasing your app to users
 
You can release your Android applications several ways. Usually, you release applications through an application marketplace such as Google Play, but you can also release applications on your own website or by sending an application directly to a user.

### Releasing through an app marketplace

If you want to distribute your apps to the broadest possible audience, releasing through an app marketplace such as Google Play is ideal.

Google Play is the premier marketplace for Android apps and is particularly useful if you want to distribute your applications to a large global audience. However, you can distribute your apps through any app marketplace you want or you can use multiple marketplaces.


### Releasing your apps on Google Play

Google Play is a robust publishing platform that helps you publicize, sell, and distribute your Android applications to users around the world. When you release your applications through Google Play you have access to a suite of developer tools that let you analyze your sales, identify market trends, and control who your applications are being distributed to. You also have access to several revenue-enhancing features such as in-app billing and application licensing. The rich array of tools and features, coupled with numerous end-user community features, makes Google Play the premier marketplace for selling and buying Android applications.


Releasing your application on Google Play is a simple process that involves three basic steps:

* Preparing promotional materials.
  To fully leverage the marketing and publicity capabilities of Google Play, you need to create promotional materials for your application, such as screenshots, videos, graphics, and promotional text.

* Configuring options and uploading assets.
  Google Play lets you target your application to a worldwide pool of users and devices. By configuring various Google Play settings, you can choose the countries you want to reach, the listing languages you want to use, and the price you want to charge in each country. You can also configure listing details such as the application type, category, and content rating. When you are done configuring options you can upload your promotional materials and your application as a draft (unpublished) application.

* Publishing the release version of your application.
  If you are satisfied that your publishing settings are correctly configured and your uploaded application is ready to be released to the public, you can simply click Publish in the Play Console and within minutes your application will be live and available for download around the world.


### Releasing through a website

If you do not want to release your app on a marketplace like Google Play, you can make the app available for download on your own website or server, including on a private or enterprise server. To do this, you must first prepare your application for release in the normal way. Then all you need to do is host the release-ready APK file on your website and provide a download link to users.

When users browse to the download link from their Android-powered devices, the file is downloaded and Android system automatically starts installing it on the device. However, the installation process will start automatically only if the user has configured their Settings to allow the installation of apps from unknown sources.

Although it is relatively easy to release your application on your own website, it can be inefficient. For example, if you want to monetize your application you will have to process and track all financial transactions yourself and you will not be able to use Google Play's In-app Billing service to sell in-app products. In addition, you will not be able to use the Licensing service to help prevent unauthorized installation and use of your application

### User opt-in for unknown apps and sources

Android protects users from inadvertent download and install of apps from locations other than a first-party app store, such as Google Play, which is trusted. Android blocks such installs until the user opts into allowing the installation of apps from other sources. The opt-in process depends on the version of Android running on the user's device:
  
* On devices running Android 8.0 (API level 26) and higher, users must navigate to the Install unknown apps system settings screen to enable app installations from a particular source.
* On devices running Android 7.1.1 (API level 25) and lower, users must either enable the Unknown sources system setting or allow a single installation of an unknown app.  
  
  
 ### Install unknown apps
 
 On devices running Android 8.0 (API level 26) and higher, users must grant permission to install apps from a source that isn't a first-party app store. To do so, they must enable the Allow app installs setting for that source within the Install unknown apps system settings screen.
 
 
### Gathering materials and resources
To begin preparing your application for release you need to gather several supporting items. At a minimum this includes cryptographic keys for signing your application and an application icon. You might also want to include an end-user license agreement.

* Cryptographic keys
  The Android system requires that each installed application be digitally signed with a certificate that is owned by the application's developer (that is, a certificate for which the developer holds the private key). The Android system uses the certificate as a means of identifying the author of an application and establishing trust relationships between applications. The certificate that you use for signing does not need to be signed by a certificate authority; the Android system allows you to sign your applications with a self-signed certificate
  
* Application icon
  Be sure you have an application icon and that it meets the recommended icon guidelines. Your application's icon helps users identify your application on a device's Home screen and in the Launcher window. It also appears in Manage Applications, My Downloads, and elsewhere. In addition, publishing services such as Google Play display your icon to users.
  
* End-user license agreement
  Consider preparing an End User License Agreement (EULA) for your application. A EULA can help protect your person, organization, and intellectual property, and Google recommend that you provide one with your application.

* Miscellaneous materials
  You might also have to prepare promotional and marketing materials to publicize your application. For example, if you are releasing your application on Google Play you will need to prepare some promotional text and you will need to create screenshots of your application.
  
### Configuring Your application for release

After you gather all of your supporting materials you can start configuring your application for release. This section provides a summary of the configuration changes Android recommend that you make to your source code, resource files, and application manifest prior to releasing your application. Although most of the configuration changes listed in this section are optional, they are considered good coding practices and Android encourage you to implement them. In some cases, you may have already made these configuration changes as part of your development process.
  
* Choose a good package name
  Make sure you choose a package name that is suitable over the life of your application. You cannot change the package name after you distribute your application to users. You can set the package name in application's manifest file.
  
* Turn off logging and debugging
  Make sure you deactivate logging and disable the debugging option before you build your application for release. You can deactivate logging by removing calls to Log methods in your source files. You can disable debugging by removing the android:debuggable attribute from the 'application' tag in your manifest file, or by setting the android:debuggable attribute to false in your manifest file. Also, remove any log files or static test files that were created in your project.

Also, you should remove all Debug tracing calls that you added to your code, such as startMethodTracing() and stopMethodTracing() method calls.


```
Important: Ensure that you disable debugging for your app if using WebView to display paid for content or if using JavaScript interfaces, since debugging allows users to inject scripts and extract content using Chrome DevTools. To disable debugging, use the WebView.setWebContentsDebuggingEnabled() method.

```  

* Clean up your project directories
  Clean up your project and make sure it conforms to the directory structure described in Android Projects. Leaving stray or orphaned files in your project can prevent your application from compiling and cause your application to behave unpredictably. At a minimum you should do the following cleanup tasks:

Review the contents of your jni/, lib/, and src/ directories. The jni/ directory should contain only source files associated with the Android NDK, such as .c, .cpp, .h, and .mk files. The lib/ directory should contain only third-party library files or private library files, including prebuilt shared and static libraries (for example, .so files). The src/ directory should contain only the source files for your application (.java and .aidl files). The src/ directory should not contain any .jar files.
Check your project for private or proprietary data files that your application does not use and remove them. For example, look in your project's res/ directory for old drawable files, layout files, and values files that you are no longer using and delete them.
Check your lib/ directory for test libraries and remove them if they are no longer being used by your application.
Review the contents of your assets/ directory and your res/raw/ directory for raw asset files and static files that you need to update or remove prior to release.
  
* Review and update your manifest and Gradle build settings

Verify that the following manifest and build files items are set correctly:

uses-permission element
You should specify only those permissions that are relevant and required for your application.

android:icon and android:label attributes
You must specify values for these attributes, which are located in the application element.

android:versionCode and android:versionName attributes.
We recommend that you specify values for these attributes, which are located in the manifest element.

There are several additional manifest or build file elements that you can set if you are releasing your application on Google Play. For example, the android:minSdkVersion and android:targetSdkVersion attributes, which are located in the uses-sdk element. For more information about these and other Google Play settings, see Filters on Google Play.

 * Address compatibility issues 

   Android provides several tools and techniques to make your application compatible with a wide range of devices. To make your application available to the largest number of users, consider doing the following:

Add support for multiple screen configurations
Make sure you meet the best practices for supporting multiple screens. By supporting multiple screen configurations you can create an application that functions properly and looks good on any of the screen sizes supported by Android.
  
Optimize your application for Android tablet devices.
If your application is designed for devices older than Android 3.0, make it compatible with Android 3.0 devices.

Consider using the Support Librar
If your application is designed for devices running Android 3.x, make your application compatible with older versions of Android by adding the Support Library to your application project. The Support Library provides static support libraries that you can add to your Android application, which enables you to use APIs that are either not available on older platform versions or use utility APIs that are not part of the framework APIs.


* Update URLs for servers and services
  If your application accesses remote servers or services, make sure you are using the production URL or path for the server or service and not a test URL or path.

* Implement licensing (if you are releasing on Google Play)
  If you are releasing a paid application through Google Play, consider adding support for Google Play Licensing. Licensing lets you control access to your application based on whether the current user has purchased it. Using Google Play Licensing is optional even if you are releasing your app through Google Play.
  
  
### Preparing external servers and resources
If your application relies on a remote server, make sure the server is secure and that it is configured for production use. This is particularly important if you are implementing in-app billing in your application and you are performing the signature verification step on a remote server.

Also, if your application fetches content from a remote server or a real-time service (such as a content feed), be sure the content you are providing is up to date and production-ready.
 
## Version your app

Versioning is a critical component of your app upgrade and maintenance strategy. Versioning is important because:

* Users need to have specific information about the app version that is installed on their devices and the upgrade versions available for installation.
* Other apps — including other apps that you publish as a suite — need to query the system for your app's version, to determine compatibility and identify dependencies.
* Services through which you will publish your app(s) may also need to query your app for its version, so that they can display the version to users. A publishing service may also need to check the app version to determine compatibility and establish upgrade/downgrade relationships.

The Android system uses your app's version information to protect against downgrades.The system does not use app version information to enforce restrictions on upgrades or compatibility of third-party apps. Your app must enforce any version restrictions and should tell users about them.

The Android system does enforce system version compatibility as expressed by the minSdkVersion setting in the build files. This setting allows an app to specify the minimum system API with which it is compatible.
 
 
### Set application version information
To define the version information for your app, set values for the version settings in the Gradle build files. These values are then merged into your app's manifest file during the build process.

```
Note: If your app defines the app version directly in the <manifest> element, the version values in the Gradle build file will override the settings in the manifest. Additionally, defining these settings in the Gradle build files allows you to specify different values for different versions of your app. For greater flexibility and to avoid potential overwriting when the manifest is merged, you should remove these attributes from the <manifest> element and define your version settings in the Gradle build files instead.

```

Two settings are available, and you should always define values for both of them:


* versionCode — A positive integer used as an internal version number. This number is used only to determine whether one version is more recent than another, with higher numbers indicating more recent versions. This is not the version number shown to users; that number is set by the versionName setting, below. The Android system uses the versionCode value to protect against downgrades by preventing users from installing an APK with a lower versionCode than the version currently installed on their device.
  The value is a positive integer so that other apps can programmatically evaluate it, for example to check an upgrade or downgrade relationship. You can set the value to any positive integer you want, however you should make sure that each successive release of your app uses a greater value. You cannot upload an APK to the Play Store with a versionCode you have already used for a previous version.

```
Note: In some specific situations, you might wish to upload a version of your app with a lower versionCode than the most recent version. For example, if you are publishing multiple APKs, you might have pre-set versionCode ranges for specific APKs. For more about assigning versionCode values for multiple APKs,
```

Typically, you would release the first version of your app with versionCode set to 1, then monotonically increase the value with each release, regardless of whether the release constitutes a major or minor release. This means that the versionCode value does not necessarily have a strong resemblance to the app release version that is visible to the user (see versionName, below). Apps and publishing services should not display this version value to users.

* versionName — A string used as the version number shown to users. This setting can be specified as a raw string or as a reference to a string resource.
  The value is a string so that you can describe the app version as a 'major.minor.point' string, or as any other type of absolute or relative version identifier. The versionName has no purpose other than to be displayed to users.


 ### Specify API level requirements
 If your app requires a specific minimum version of the Android platform, you can specify that version requirement as API level settings in the app's build.gradle file. During the build process, these settings are merged into your app's manifest file. Specifying API level requirements ensures that your app can only be installed on devices that are running a compatible version of the Android platform.
 
There are two API level settings available:

* minSdkVersion — The minimum version of the Android platform on which the app will run, specified by the platform's API level identifier.
* targetSdkVersion — Specifies the API level on which the app is designed to run. In some cases, this allows the app to use manifest elements or behaviors defined in the target API level, rather than being restricted to using only those defined for the minimum API level.

### Sign your app
Android requires that all APKs be digitally signed with a certificate before they are installed on a device or updated. If you use Android App Bundles, you need to sign only your app bundle before you upload it to the Play Console, and Play App Signing takes care of the rest. However, you can also manually sign your app for upload to Google Play and other app stores.

### Play App Signing

With Play App Signing, Google manages and protects your app's signing key for you and uses it to sign your APKs for distribution. And, because app bundles defer building and signing APKs to the Google Play Store, you need to opt in to Play App Signing before you upload your app bundle. Doing so lets you benefit from the following:

* Use the Android App Bundle and support Google Play’s advanced delivery modes. The Android App Bundle makes your app much smaller, your releases simpler, and makes it possible to use feature modules and offer instant experiences.
* Increase the security of your signing key, and make it possible to use a separate upload key to sign the app bundle you upload to Google Play.

### Keystores, keys, and certificates

Java Keystores (.jks or .keystore) are binary files that serve as repositories of certificates and private keys.

A public key certificate (.der or .pem files), also known as a digital certificate or an identity certificate, contains the public key of a public/private key pair, as well as some other metadata identifying the owner (for example, name and location) who holds the corresponding private key.

The following are the different types of keys you should understand:

App signing key: The key that is used to sign APKs that are installed on a user's device. As part of Android’s secure update model, the signing key never changes during the lifetime of your app. The app signing key is private and must be kept secret. You can, however, share the certificate that is generated using your app signing key.
Upload key: The key you use to sign the app bundle or APK before you upload it for app signing with Google Play. You must keep the upload key secret. However, you can share the certificate that is generated using your upload key. You may generate an upload key in one of the following ways:

* If you choose for Google to generate the app signing key for you when you opt in, then the key you use to sign your app for release is designated as your upload key.
* If you provide the app signing key to Google when opting in your new or existing app, then you have the option to generate a new upload key during or after opting in for increased security.
* If you do not generate a new upload key, you continue to use your app signing key as your upload key to sign each release.

### Working with API providers
You can download the certificate for the app signing key and your upload key from the Release > Setup > App Integrity page in the Play Console. This is used to register public key(s) with API providers; it's intended to be shared, as it does not contain your private key.

A certificate fingerprint is a short and unique representation of a certificate that is often requested by API providers alongside the package name to register an app to use their service. The MD5, SHA-1 and SHA-256 fingerprints of the upload and app signing certificates can be found on the app signing page of the Play Console. Other fingerprints can also be computed by downloading the original certificate (.der) from the same page.

## Upload your app to the Play Console

After you build and sign the release version of your app, the next step is to upload it to Google Play to inspect, test, and publish your app. Before you get started, you might want to make sure you satisfy the following:

* If you haven't already done so, enroll into Play App Signing, which is the recommended way to upload and sign your app. If you build and upload an Android App Bundle, you must enroll in app Play App Signing.
* Google Play supports compressed app downloads of only 150 MB or less.

After you've met the requirements above, go ahead and upload your app to the Play Console

```
Note : https://support.google.com/googleplay/android-developer/answer/9859348?visit_id=637610099730072495-779093754&rd=1#zippy=%2Cplay-app-signing%2Capp-bundles-and-apks%2Cincluded-app-bundles-and-apks%2Cnot-included-app-bundles-and-apks%2Cdeclare-permissions-for-your-app-optional%2Crelease-name%2Cwhats-new-in-this-release
```