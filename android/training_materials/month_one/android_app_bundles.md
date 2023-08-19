# Android App Bundles

An Android App Bundle is a publishing format that includes all your app’s compiled code and resources, and defers APK generation and signing to Google Play.

Google Play uses your app bundle to generate and serve optimized APKs for each device configuration, so only the code and resources that are needed for a specific device are downloaded to run your app. You no longer have to build, sign, and manage multiple APKs to optimize support for different devices, and users get smaller, more-optimized downloads.

Most app projects won’t require much effort to build app bundles that support serving optimized APKs. For example, if you already organize your app’s code and resources according to established conventions, simply build signed Android App Bundles using Android Studio or using the command line, and upload them to Google Play. Optimized APK serving then becomes an automatic benefit.

When you use the app bundle format to publish your app, you can also optionally take advantage of Play Feature Delivery, which allows you to add feature modules to your app project. These modules contain features and resources that are only included with your app based on conditions that you specify, or are available later at runtime for download Using the Play Core Library.

Game developers who publish their apps with app bundles can use Play Asset Delivery: Google Play’s solution for delivering large amounts of game assets that offers developers flexible delivery methods and high performance.

## Compressed download size restriction

Publishing with Android App Bundles helps your users to install your app with the smallest downloads possible and increases the compressed download size limit to 150 MB. That is, when a user downloads your app, the total size of the compressed APKs required to install your app (for example, the base APK + configuration APKs) must be no more than 150 MB. Any subsequent downloads, such as downloading a feature module (and its configuration APKs) on demand, must also meet this compressed download size restriction. Asset packs do not contribute to this size limit, but they do have other size restrictions.

When you upload your app bundle, if the Play Console finds any of the possible downloads of your app or its on demand features to be more than 150 MB, you get an error.


Keep in mind, Android App Bundles do not support APK expansion (*.obb) files. So, if you encounter this error when publishing your app bundle, use one of the following resources to reduce compressed APK download sizes:

* Make sure you enable all configuration APKs by setting enableSplit = true for each type of configuration APK. This makes sure that users download only the code and resources they need to run your app on their device.
* Make sure you shrink your app by removing unused code and resources.
* Follow best practices to further reduce app size.
* Consider converting features that are used by only some of your users into feature modules that your app can download later, on demand. Keep in mind, this may require some refactoring of your app, so make sure to first try the other suggestions described above

## Other considerations

The following are the currently known issues when building or serving your app with Android App Bundles

* Partial installs of sideloaded apps—that is, apps that are not installed using the Google Play Store and are missing one or more required split APKs—fail on all Google-certified devices and devices running Android 10 (API level 29) or higher. When downloading your app through the Google Play Store, Google ensures that all required components of the app are installed.
* If you use tools that dynamically modify resource tables, APKs generated from app bundles might behave unexpectedly. So, when building an app bundle, it is recommended that you disable such tools.
* It is currently possible to configure properties in a feature module’s build configuration that conflict with those from the base (or other) modules. For example, you can set buildTypes.release.debuggable = true in the base module and set it to false in a feature module. Such conflicts might cause build and runtime issues. Keep in mind, by default, feature modules inherit some build configurations from the base module. So, make sure you understand which configurations you should keep, and which ones you should omit, in your feature module build configuration.


## Configure the base module

An app bundle is different from an APK in that you can’t deploy one to a device. Rather, it’s a publishing format that includes all your app’s compiled code and resources in a single build artifact. So, after you upload your signed app bundle, Google Play has everything it needs to build and sign your app’s APKs, and serve them to users.

### Get started

Most app projects won’t require much effort to support Android App Bundles. That’s because the module that includes code and resources for your app’s base APK is the standard app module, which you get by default when you create a new app project in Android Studio. That is, the module that applies the application plugin below to its build.gradle file provides the code and resources for the base functionality of your app.

```
plugins {
    // The standard application plugin creates your app's base module.
    id("com.android.application")
}

```

In addition to providing the core functionality for your app, the base module also provides many of the build configurations and manifest entries that affect your entire app project.

### The base module build configuration

For most existing app projects, you don’t need to change anything in your base module’s build configuration. However, if you are considering adding feature modules to your app project or if you previously released your app using multiple APKs, there are some aspects to the base module’s build configuration that you should keep in mind.

### Version code and app updates

With Android App Bundles, you no longer have to manage version codes for multiple APKs that you upload to Google Play. Instead, you manage only one version code in the base module of your app, as shown below:

```

// In your base module build.gradle file
android {
    defaultConfig {
        …
        // You specify your app’s version code only in the base module.
        versionCode 5
        versionName "1.0"
    }
}

```
After you upload your app bundle, Google Play uses the version code in your base module to assign the same version code to all the APKs it generates from that bundle. That is, when a device downloads and installs your app, all split APKs for that app share the same version code.

When you want to update your app with new code or resources, you must update the version code in your app’s base module, and build a new, full app bundle. When you upload that app bundle to Google Play, it generates a new set of APKs based on the version code the base module specifies. Subsequently, when users update your app, Google Play serves them updated versions of all APKs currently installed on the device. That is, all installed APKs are updated to the new version code.

### Other considerations

* App signing: If you include signing information in your build files, you should only include it in the base module’s build configuration file. For more information, see Configure Gradle to sign your app.
* Code shrinking: If you want to enable code shrinking for your entire app project (including its feature modules), you must do so from the base module’s build.gradle file. That is, you can include custom ProGuard rules in a feature module, but the minifyEnabled property in feature module build configurations is ignored.
* The splits block is ignored: When building an app bundle, Gradle ignores properties in the android.splits block. If you want to control which types of configuration APKs your app bundle supports, instead use android.bundle to disable types of configuration APKs.
* App versioning: The base module determines the version code and version name for your entire app project. For more information, go to the section about how to Manage app updates.

### Re-enable or disable types of configuration APKs

By default, when you build an app bundle, it supports generating configuration APKs for each set of language resources, screen density resources, and ABI libraries. Using the android.bundle block in your base module’s build.gradle file, as shown below, you can disable support for one or more types of configuration APKs:

```

android {
    // When building Android App Bundles, the splits block is ignored.
    // You can remove it, unless you're going to continue to build multiple
    // APKs in parallel with the app bundle
    splits {...}

    // Instead, use the bundle block to control which types of configuration APKs
    // you want your app bundle to support.
    bundle {
        language {
            // This property is set to true by default.
            // You can specify `false` to turn off
            // generating configuration APKs for language resources.
            // These resources are instead packaged with each base and
            // feature APK.
            // Continue reading below to learn about situations when an app
            // might change setting to `false`, otherwise consider leaving
            // the default on for more optimized downloads.
            enableSplit = false
        }
        density {
            // This property is set to true by default.
            enableSplit = true
        }
        abi {
            // This property is set to true by default.
            enableSplit = true
        }
    }
}

```

### Handling language changes

Google Play determines which language resources to install with the app based on the language selection in the user's device settings. Consider a user who changes their default system language after already downloading your app. If your app supports that language, the device requests and downloads additional configuration APKs for those language resources from Google Play.

For apps that offer a language picker inside the application and dynamically change the app's language, independent of the system level language setting, you must make some changes to prevent crashes due to missing resources. Either set the android.bundle.language.enableSplit property to false, or consider implementing on-demand language downloads using the Play Core library.

## Build and test your Android App Bundle

Android App Bundles are the recommended way to build, publish, and distribute your app across multiple device configurations. App bundles also enable advanced features, such as Play Feature Delivery, Play Asset Delivery, and instant experiences. Whether you are just starting to adopt app bundles or are developing for more advanced use cases, this page provides an overview of the various strategies available for you to test your app at each stage of development.

### Build an app bundle using Android Studio

If you’re using Android Studio, you can build your project as a signed app bundle in just a few clicks. If you're not using the IDE, you can build an app bundle from the command line. Then, upload your app bundle to the Play Console to test or publish your app.

### To build app bundles, follow these steps:

* Download Android Studio 3.2 or higher—it's the easiest way to add feature modules and build app bundles.

* Build an Android App Bundle using Android Studio. You can also deploy your app to a connected device from an app bundle by modifying your run/debug configuration and selecting the option to deploy APK from app bundle. Keep in mind, using this option results in longer build times when compared to building and deploying only an APK.

 If you're not using the IDE, you can instead build an app bundle from the command line.
 
* Deploy your Android App Bundle by using it to generate APKs that you deploy to a device.

* Enroll into app Play App Signing. Otherwise, you can't upload your app bundle to the Play Console.

* Publish your app bundle to Google Play.


## Deploy using app bundles with Android Studio

You can build your app as an Android App Bundle and deploy it to a connected device right from the IDE. Because the IDE and Google Play use the same tools to extract and install APKs on a device, this local testing strategy helps you to verify the following:

* You can build your app as an app bundle.
* The IDE is able to extract APKs for a target device configuration from the app bundle.
* Features that you separate into feature modules are compatible with your app’s base module.
* Your app functions on the target device as you expect.

By default, when you deploy your app from Android Studio to a connected device, the IDE builds and deploys APKs for the target device configuration. That’s because building APKs for a particular device configuration is faster than building an app bundle for all device configurations your app supports.

If you want to test building your app as an app bundle, and then deploying APKs from that app bundle to your connected device, you need to edit the default Run/Debug configuration as follows:

* Select Run > Edit Configurations from the menu bar.
* Select a run/debug configuration from the left pane.
* In the right pane, select the General tab.
* Select APK from app bundle from the dropdown menu next to Deploy.
* If your app includes an instant app experience that you want to test, check the box next to Deploy as an instant app.
* If your app includes feature modules, you can select which modules you want to deploy by checking the box next to each module. By default, Android Studio deploys all feature modules and always deploys the base app module.
* Click Apply or OK.
* When you select Run > Run from the menu bar, Android Studio builds an app bundle and uses it to deploy only the APKs required by the connected device and feature modules you selected.

### Build and test from the command line

The tools that Android Studio and Google Play use to build your app bundle and convert it into APKs are available to you from the command line. That is, you can invoke these tools from the command line to locally build and deploy your app from an Android App Bundle.

These local testing tools are useful for the following:

* Integrating configurable builds of app bundles into your Continuous Integration (CI) server or other custom build environment.
* Automating deployment your app from an app bundle to one or more connected test devices.
* Emulating downloads of your app from Google Play onto a connected device.

### Build an app bundle from the command line

If you want to build your app bundle from the command line, you can do so using either bundletool or the Android Gradle plugin.

Android Gradle plugin: Authored by Google, this plugin comes bundled with Android Studio and is also available as a Maven repository. The plugin defines commands that you can execute from the command line to build an app bundle. While the plugin provides the easiest method of building your app bundle, you’ll need to use it via bundletool to deploy your app to a test device.

bundletool: This command-line tool is what both the Android Gradle plugin and Google Play use to build your app as an app bundle. Keep in mind, using bundletool to build your app bundle is a lot more complicated than simply running a Gradle task using the plugin. That’s because the plugin automates certain prerequisites to building an app bundle. However, this tool is useful for developers who want to generate app bundle artifacts in their CI workflow.

### Deploy your app from the command line

Although the Android Gradle plugin is the easiest way to build your app bundle from the command line, you should use bundletool to deploy your app from an app bundle to a connected device. That’s because bundletool provides commands designed specifically to help you test your app bundle and emulate distribution through Google Play.

The following are the different types of scenarios you can test for using bundletool:

* Generate an APK set that includes split APKs for all device configurations your app supports. Building an APK set is typically required before bundletool can deploy your app to a connected device.
 If you don't want to build a set of all your app’s split APKs, you can generate a device-specific set of APKs based on a connected device or device specification JSON.
* Deploy your app from an APK set to a connected device. bundletool uses adb to determine the split APKs required for each device configuration, and deploys only those APKs to the device. If you have multiple devices, you can also pass the device ID to bundletool to target a specific device.
* Locally test feature delivery options. You can use bundletool to emulate your device downloading and installing feature modules from Google Play, without actually publishing your app to the Play Console. This is helpful if you want to locally test how your app handles on-demand module download requests and failures.
* Estimate your app’s download size for a given device configuration. This is helpful to better understand the user experience of downloading your app and checking whether your app meets the compressed download size restriction for app bundles or enabling instant experiences.

### Test your app bundle on Play

While the other testing strategies described on this page don’t require you to upload your app to Play, testing using the Play Console provides the most accurate representation of the user experience. Whether you want to share your app with your internal stakeholders, your internal QA team, a closed group of alpha testers, or a wider audience of beta testers, the Play Console provides you with several testing strategies.

Use the Play Console to test your app for the following reasons:

* You want the most accurate representation of the user experience of downloading your app and, optionally, installing features on demand.
* You want to provide easy access to a group of testers.
* You want to scope tests to QA, alpha, and beta testers.
* You want to access a history of app uploads that you can test on a device. For example, if you want to compare versions for performance regressions.

### Quickly share your app with a URL

While the Play Console test tracks provide a method of progressing your app through formal testing stages, sometimes you want to quickly share your app with trusted testers over less formal channels, such as email or a text message.

By uploading your app bundle to the Play Console quick sharing page, you can generate a URL that you can easily share with others. Sharing your app this way provides these benefits:

* Authorize anyone on your team to upload test builds, without giving them access to your app in Play Console.
* Testers get access only to the specific test version of your app that was shared with them.
* Test builds can be signed with any key or not signed at all, so uploaders also don’t need access to your production or upload key.
* Version codes don’t need to be unique, so you can reuse an existing version code and don’t need to increment it to upload.
* Test custom delivery options, such as downloading features on demand and in-app updates.
* Capture important data and logs by sharing a debuggable version of your app.

When users click on the URL from their Android device, the device automatically opens the Google Play Store to download the test version of your app.

### Download historical versions of your app

You and your testers can also download historical versions of your app that you’ve uploaded to a production or test track. This can be useful if, for example, you want to quickly test an earlier version of your app to check for performance regressions.

Visit the Play Console app bundle explorer page and navigate to the download tab of any version you want to download to copy the install link. Alternatively, if you know the package name and version code for the version of your app you want to test, simply visit the following link from your test device:

```
https://play.google.com/apps/test/package-name/version-code
```

### Upload your app to a test track

When you upload your app and create a release in the Play Console, you can progress your release through multiple testing stages before pushing to production:

* Internal test: Create an internal test release to quickly distribute your app for internal testing and quality assurance checks.
* Closed: Create a closed release to test pre-release versions of your app with a larger set of testers. Once you've tested with a smaller group of employees or trusted users, you can expand your test to an open release. On your App releases page, an Alpha track will be available as your initial closed test. If needed, you can also create and name additional closed tracks.
* Open: Create an open release after you've tested a closed release. Your open release can include a wider range of users for testing, before your app goes live in production.

Progressing your app through each of these testing stages allows you to open your app to wider audiences of testers before releasing your app to production.

### Use pre-launch reports to identify issues

When you upload an APK or app bundle to the open or closed track, you can identify issues for a wide range of devices running different versions of Android.

The pre-launch report on your Play Console helps you identify potential issues with the following:

* Stability
* Android compatibility
* Performance
* Accessibility
* Security vulnerabilities

After you upload your app bundle, test devices automatically launch and crawl your app for several minutes. The crawl performs basic actions every few seconds on your app, such as typing, tapping, and swiping.

After tests are complete, your results will be available in the pre-launch report section of your Play Console.

### Browse and download APKs for specific device configurations

When you upload your app bundle, the Play Console automatically generates split APKs and multi-APKs for all device configurations your app supports. In the Play Console, you can use the app bundle explorer to see all APK artifacts that Google Play generates, inspect data such as supported devices and your app’s delivery configuration, and download the generated APKs to deploy and test locally.

## Test your app bundle with Firebase App Distribution

Firebase App Distribution makes it easy to distribute pre-release versions of your app to trusted testers so you can get valuable feedback before launch.

App Distribution lets you manage all of your pre-release builds in a central hub, and it gives you the flexibility to distribute these builds right from the console or using the command-line tools that are already part of your workflow.


## Code transparency for app bundles

Code transparency is an optional code signing and verification mechanism for apps published with the Android App Bundle. It uses a code transparency signing key, which is solely held by the app developer.

Code transparency is independent of the signing scheme used for app bundles and APKs. The code transparency key is separate and different from the app signing key that is stored on Google’s secure infrastructure when using Play App Signing.

### How code transparency works

The process works by including a code transparency file in the bundle after it has been built, but before it is uploaded to Play Console for distribution.

The code transparency file is a JSON Web Token (JWT) that contains a list of DEX files and native libraries included in the bundle, and their hashes. It is then signed using the code transparency key that is held only by the developer.

This code transparency file is propagated to the base APK built from the app bundle (specifically to the main split of the base module). It can then be verified that:

* All DEX and native code files present in the APKs have matching hashes in the code transparency file.
* The public key component of the code transparency signing key in the app matches the public key of the developer (which must be provided by the developer over a separate, secure channel).

Together, this information verifies that the code contained in the APKs matches what the developer had intended, and that it has not been modified.

The code transparency file does not verify resources, assets, the Android Manifest, or any other files that are not DEX files or native libraries contained in the lib/ folder.

Code transparency verification is used solely for the purpose of inspection by developers and end users, who want to ensure that code they're running matches the code that was originally built and signed by the app developer.

### Known limitations

There are certain situations when code transparency cannot be used:

* Apps that specify the sharedUserId attribute in the manifest. Such applications may share their process with other applications, which makes it difficult to make assurances about the code they're executing.
* Apps using anti-tamper protection or any other service that makes code changes after the code transparency file is generated will cause the code transparency verification to fail.
* Apps that use legacy Multidex on API levels below 21 (Android 5.0) and use feature modules. Code transparency will continue to work when the app is installed by Google Play on Android 5.0+ devices. Code transparency will be disabled on older OS versions.

### How to add code transparency

Before you can add code transparency to your app, make sure that you have a private and public key pair that you can use for code transparency signing. This should be a unique key that is different from the app signing key that you use for Play App Signing, and it must be held securely and never shared outside of your organization.

If you don't have a key, you can follow the instructions in the Sign your app guide to generate one on your machine. Code transparency uses a standard keystore file, so even though the guide is for app signing, the key generation process is the same.

Code transparency support requires bundletool version 1.7.0 or newer.

Run the following command to add code transparency to an Android App Bundle. The key used must be one that you will only use for code transparency, and not the upload key that is used to sign the app for publishing

```

bundletool add-transparency \
  --bundle=/MyApp/my_app.aab \
  --output=/MyApp/my_app_with_transparency.aab \
  --ks=/MyApp/keystore.jks \
  --ks-pass=file:/MyApp/keystore.pwd \
  --ks-key-alias=MyKeyAlias \
  --key-pass=file:/MyApp/key.pwd
  
```

Alternatively, if you want to use your own signing tools, you can use bundletool to generate the unsigned code transparency file, sign it in a separate environment and inject the signature into the bundle:

```

# Generate code transparency file
bundletool add-transparency \
  --mode=generate_code_transparency_file \
  --bundle=/MyApp/my_app.aab \
  --output=/MyApp/code_transaprency_file.jwt \
  --transparency-key-certificate=/MyApp/transparency.cert

# Add code transparency signature to the bundle
bundletool add-transparency \
  --mode=inject_signature \
  --bundle=/MyApp/my_app.aab \
  --output=/MyApp/my_app_with_transparency.aab \
  --transparency-key-certificate=/MyApp/transparency.cert \
  --transparency-signature=/MyApp/signature

```

### Verify code transparency of an app

There are different methods for verifying code against the code transparency file, depending on if you have the APKs installed on an Android device or downloaded locally to your computer.

```

Important: To verify that the signature comes from the original developer, the printed fingerprint from one of the following methods must be compared with the public key communicated by the developer through a trusted channel. For example, the developer can host their public certificate on a secure website that is known to belong to them. To ensure no other changes have been made to the app, checking the APK signature is also necessary and recommended.

```

#### Using Bundletool to check an app bundle or APK set

You can use bundletool to verify code transparency in an app bundle or an APK set. Use the check-transparency command to print the public certificate fingerprint:

```
# For checking a bundle:
bundletool check-transparency \
  --mode=bundle \
  --bundle=/MyApp/my_app_with_transparency.aab

No APK present. APK signature was not checked.
Code transparency signature is valid. SHA-256 fingerprint of the code transparency key certificate (must be compared with the developer's public key manually): 01 23 45 67 89 AB CD EF ..
Code transparency verified: code related file contents match the code transparency file.


# For checking a ZIP containing app's APK splits:
bundletool check-transparency \
  --mode=apk \
  --apk-zip=/MyApp/my_app_with_transparency.zip

APK signature is valid. SHA-256 fingerprint of the apk signing key certificate (must be compared with the developer's public key manually): 02 34 E5 98 CD A7 B2 12 ..
Code transparency signature is valid. SHA-256 fingerprint of the code transparency key certificate (must be compared with the developer's public key manually): 01 23 45 67 89 AB CD EF ..
Code transparency verified: code related file contents match the code transparency file.
```

You can optionally specify the public certificate that you want to verify the bundle or APK set against, so that you don't have to compare the hashes manually:

```

bundletool check-transparency \
  --mode=bundle \
  --bundle=/MyApp/my_app_with_transparency.aab \
  --transparency-key-certificate=/MyApp/transparency.cert

No APK present. APK signature was not checked.
Code transparency signature verified for the provided code transparency key certificate.
Code transparency verified: code related file contents match the code transparency file.


bundletool check-transparency \
  --mode=apk \
  --apk-zip=/MyApp/my_app_with_transparency.zip \
  --apk-signing-key-certificate=/MyApp/apk.cert \
  --transparency-key-certificate=/MyApp/transparency.cert

APK signature verified for the provided apk signing key certificate.
Code transparency signature verified for the provided code transparency key certificate.
Code transparency verified: code related file contents match the code transparency file.

```

### Using Bundletool to check an app installed on a device

For checking an app that has been installed on an Android device, make sure the device is connected to your computer via ADB and issue to following command:

```

bundletool check-transparency \
  --mode=connected_device \
  --package-name="com.my.app"

APK signature is valid. SHA-256 fingerprint of the apk signing key certificate (must be compared with the developer's public key manually): 02 34 E5 98 CD A7 B2 12 ..
Code transparency signature is valid. SHA-256 fingerprint of the code transparency key certificate (must be compared with the developer's public key manually): 01 23 45 67 89 AB CD EF ..
Code transparency verified: code related file contents match the code transparency file.

```

The connected device transparency check can also optionally verify the signature against a public key that you specify:

```

bundletool check-transparency \
  --mode=connected-device \
  --package-name="com.my.app" \
  --apk-signing-key-certificate=/MyApp/apk.cert \
  --transparency-key-certificate=/MyApp/transparency.cert

APK signature verified for the provided apk signing key certificate.
Code transparency signature verified for the provided code transparency key certificate.
Code transparency verified: code related file contents match the code transparency file.

```

## The Android App Bundle format

An Android App Bundle is a file (with the .aab file extension) that you upload to Google Play.

App bundles are signed binaries that organize your app’s code and resources into modules, as illustrated in figure 1. Code and resources for each module are organized similarly to what you would find in an APK—and that makes sense because each of these modules may be generated as separate APKs. Google Play then uses the app bundle to generate the various APKs that are served to users, such as the base APK, feature APKs, configuration APKs, and (for devices that do not support split APKs) multi-APKs. The directories that are colored in blue—such as the drawable/, values/, and lib/ directories—represent code and resources that Google Play uses to create configuration APKs for each module.

```
Note: You build an app bundle for each unique app, or applicationID. That is, if you use product flavors to create multiple versions of your app from a single app project, and each of those versions use a unique applicationID, you need to build a separate app bundle for each version of your app.

```

## Overview of split APKs

A fundamental component of serving optimized applications is the split APK mechanism available on Android 5.0 (API level 21) and higher. Split APKs are very similar to regular APKs—they include compiled DEX bytecode, resources, and an Android manifest. However, the Android platform is able to treat multiple installed split APKs as a single app. That is, you can install multiple split APKs that have access to common code and resources, and appear as one installed app on the device.

The benefit of split APKs is the ability to break up a monolithic APK—that is, an APK that includes code and resources for all features and device configurations your app supports—into smaller, discrete packages that are installed on a user’s device as required.

For example, one split APK may include the code and resources for an additional feature that only a few of your users need, while another split APK includes resources for only a specific language or screen density. Each of these split APKs is downloaded and installed when the user requests it or it’s required by the device.

The following describes the different types of APKs that may be installed together on a device to form your full app experience.

* Base APK: This APK contains code and resources that all other split APKs can access and provides the basic functionality for your app. When a user requests to download your app, this APK is downloaded and installed first. That’s because only the base APK’s manifest contains a full declaration of your app’s services, content providers, permissions, platform version requirements, and dependencies on system features. Google Play generates the base APK for your app from your project’s app (or base) module. If you are concerned with reducing your app’s initial download size, it’s important to keep in mind that all code and resources included in this module are included in your app’s base APK.
* Configuration APKs: Each of these APKs includes native libraries and resources for a specific screen density, CPU architecture, or language. When a user downloads your app, their device downloads and installs only the configuration APKs that target their device. Each configuration APK is a dependency of either a base APK or feature module APK. That is, they are downloaded and installed along with the APK they provide code and resources for. Unlike the base and feature modules, you don't create a separate module for configuration APKs. If you use standard practices to organize alternative, configuration-specific resources for your base and feature modules, Google Play automatically generates configuration APKs for you.
* Feature module APKs: Each of these APKs contains code and resources for a feature of your app that you modularize using feature modules. You can then customize how and when that feature is downloaded onto a device. For example, using the Play Core Library, features may be installed on demand after the base APK is installed on the device to provide additional functionality to the user. Consider a chat app that downloads and installs the ability to capture and send photos only when the user requests to use that functionality. Because feature modules may not be available at install time, you should include any common code and resources in the base APK. That is, your feature module should assume that code and resources of only the base APK are available at install time. Google Play generates feature module APKs for your app from your project’s feature modules.

Keep in mind, you don’t need to build these APKs yourself—Google Play does it for you using a single signed app bundle you build with Android Studio.

### Devices running Android 4.4 (API level 19) and lower

Because devices running Android 4.4 (API level 19) and lower don’t support downloading and installing split APKs, Google Play instead serves those devices a single APK, called a multi-APK, that’s optimized for the device's configuration. That is, multi-APKs represent your full app experience but do not include unnecessary code and resources—such as those for other screen densities and CPU architectures.

They do, however, include resources for all languages that your app supports. This allows, for example, users to change your app's preferred language setting without having to download a different multi-APK.

Multi-APKs do not have the ability to later download feature modules on demand. To include a feature module in this APK, you must either disable On-demand or enable Fusing when creating the feature module.

Keep in mind, with app bundles, you don't need to build, sign, upload, and manage APKs for each device configuration your app supports. You still build and upload only a single app bundle for your entire app, and Google Play takes care of the rest for you.



