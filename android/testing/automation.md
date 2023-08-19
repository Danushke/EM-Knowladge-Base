
### Automated Mobile App Testing Tools
Mobile application testing is considered as one of the important  part of software testing, as it is used
to verify and validate the overall functioning of the mobile apps and can achieve better test coverage
resulting in better test outputs.

## [Appium](http://appium.io/)
Appium made mobile app automation awesome. Appium open source tool supports iOS and Android apps,
along with native and hybrid applications. The test cases can be written in a wide variety of programming
languages including Java, c#, Ruby, Python, etc. Different design patterns can be used to minimize test
cases maintenance. Tests can be integrated with Cucumber/SpecFlow.

### Pros
  * Android, iOS and native app support
  * Open Source(Free)
  * Supports many language (Ruby, Python, Java, JavaScript, PHP, C#)
  * No need to make changes in the app in order to support automation with Appium
  * Cross Platform
  * supports multiple platforms:
  * Minimum code change required for automation
  * Supports different language scripts
  * Doesn't require an APK for use.

### Cons
  * Doesn't support image comparison.
  * The testing of android that are lower than 4.2 is not allowed.
  * Appium has limited support for hybrid app testing.
  * No support you to run Appium inspector on Microsoft windows.

## [Calabash](https://github.com/calabash/calabash-android)
Calabash enables Automated UI Acceptance Tests written in Cucumber to be run on iOS
and Android applications. Calabash works by enabling automatic UI interactions within an
application such as pressing buttons, entering text, validating responses, etc. Calabash tests can be configured to run on hundreds of different Android and iOS devices, providing real-time feedback and validations.

### Pros
  * Available for both Android and iOS apps.
  * Uses Ruby, which is a more flexible and easy-to-read language than Java
  * Tests can be controlled from a computer instead of the testing device
  * High level commands are part of the software, so complex testing is easy to utilize
  * Feature files can be written in Cucumber, a natural language code

### Cons
  * It takes time to run on an emulator or device as it always installs the app first before starting scenario.
  * If a step fails then the subsequent tests in the scenario are skipped.
  * Not Support for many complex scenarios or events.
  * We must have the code of the app for identifying the ids of various elements.

## [Robotium](https://github.com/RobotiumTech/robotium)
As an open source automated testing tool, Robotium is used frequently to evaluate a variety of Android applications. It is popularly regarded by programmers as the “Selenium for Android”. The UI testing tool further supports major versions and subversions of the Google mobile operating system. Robotium is actually a library of unit tests. While user Robotium for testing Android application, testers are required to test cases in Java.

### Pros
  * Robotium supports different versions and subversions of the Google mobile operating system.
  * Handles multiple Android activities automatically.
  * Can be used for evaluating both native and hybrid mobile applications for Android.**

###Cons
  * Does not allow testers to write test cases by choosing from a set of programming languages.
  * No support for flash & web applications
  * Test execution on one device at a time
  * Inability of handling different Applications in one test
  * No support for cross-platform testing.
  * Allow to write test cases only in Java.
  * Can not work with different Applications in on test.

### Conclusion
There are many advantages to using Appium. First, it is an open source mobile automation tool. Secondly, it can be written in any language, viz. Ruby, C# and Java, without the need to modify the apps for automation purposes. Third, Appium runs on numerous devices and emulators, making it the most scalable choice for mobile automation.
