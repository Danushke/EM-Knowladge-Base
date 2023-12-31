# Fragments

### Introduction.
A Fragment represents a reusable portion of your app's UI. A fragment defines and manages its own layout, has its own lifecycle, and can handle its own input events. Fragments cannot live on their own--they must be hosted by an activity or another fragment. The fragment’s view hierarchy becomes part of, or attaches to, the host’s view hierarchy.

Note: Some Android Jetpack libraries, such as Navigation, BottomNavigationView, and ViewPager2, are designed to work with fragments.

### Modularity
Fragments introduce modularity and reusability into your activity’s UI by allowing you to divide the UI into discrete chunks. Activities are an ideal place to put global elements around your app's user interface, such as a navigation drawer. Conversely, fragments are better suited to define and manage the UI of a single screen or portion of a screen.

Consider an app that responds to various screen sizes. On larger screens, the app should display a static navigation drawer and a list in a grid layout. On smaller screens, the app should display a bottom navigation bar and a list in a linear layout. Managing all of these variations in the activity can be unwieldy. Separating the navigation elements from the content can make this process more manageable. The activity is then responsible for displaying the correct navigation UI while the fragment displays the list with the proper layout.



![large_small](../../../assets/images/week_one/large_small.png)

Two versions of the same screen on different screen sizes. On the left, a large screen contains a navigation drawer that is controlled by the activity and a grid list that is controlled by the fragment. On the right, a small screen contains a bottom navigation bar that is controlled by the activity and a linear list that is controlled by the fragment.

Dividing your UI into fragments makes it easier to modify your activity's appearance at runtime. While your activity is in the STARTED lifecycle state or higher, fragments can be added, replaced, or removed. You can keep a record of these changes in a back stack that is managed by the activity, allowing the changes to be reversed.

You can use multiple instances of the same fragment class within the same activity, in multiple activities, or even as a child of another fragment. With this in mind, you should only provide a fragment with the logic necessary to manage its own UI. You should avoid depending on or manipulating one fragment from another.


## Create a fragment 

A fragment has its own lifecycle, receives its own input events, and you can add or remove fragments while the containing activity is running.

### Setup your environment
Fragments require a dependency on the AndroidX Fragment library. You need to add the Google Maven repository to your project's build.gradle file in order to include this dependency.

```
buildscript {
    ...

    repositories {
        google()
        ...
    }
}

allprojects {
    repositories {
        google()
        ...
    }
}
```

```
dependencies {
    val fragment_version = "1.3.6"
    // Kotlin
    implementation("androidx.fragment:fragment-ktx:$fragment_version")
}
```

To include the AndroidX Fragment library to your project, add the following dependencies in your app's build.gradle file:

### Create a fragment class

To create a fragment, extend the AndroidX Fragment class, and override its methods to insert your app logic, similar to the way you would create an Activity class. To create a minimal fragment that defines its own layout, provide your fragment's layout resource to the base constructor, as shown in the following example:

```
class ExampleFragment : Fragment(R.layout.example_fragment)
```

The Fragment library also provides more specialized fragment base classes:

* DialogFragment
Displays a floating dialog. Using this class to create a dialog is a good alternative to using the dialog helper methods in the Activity class, as fragments automatically handle the creation and cleanup of the Dialog.

* PreferenceFragmentCompat
Displays a hierarchy of Preference objects as a list. You can use PreferenceFragmentCompat to create a settings screen for your app.

### Add a fragment to an activity
Generally, your fragment must be embedded within an AndroidX FragmentActivity to contribute a portion of UI to that activity's layout. FragmentActivity is the base class for AppCompatActivity, so if you're already subclassing AppCompatActivity to provide backward compatibility in your app, then you do not need to change your activity base class.

You can add your fragment to the activity's view hierarchy either by defining the fragment in your activity's layout file or by defining a fragment container in your activity's layout file and then programmatically adding the fragment from within your activity. In either case, you need to add a FragmentContainerView that defines the location where the fragment should be placed within the activity's view hierarchy. It is strongly recommended to always use a FragmentContainerView as the container for fragments, as FragmentContainerView includes fixes specific to fragments that other view groups such as FrameLayout do not provide.

### Add a fragment via XML
To declaratively add a fragment to your activity layout's XML, use a FragmentContainerView element.

Here's an example activity layout containing a single FragmentContainerView:

```
<!-- res/layout/example_activity.xml -->
<androidx.fragment.app.FragmentContainerView
    xmlns:android="http://schemas.android.com/apk/res/android"
    android:id="@+id/fragment_container_view"
    android:layout_width="match_parent"
    android:layout_height="match_parent"
    android:name="com.example.ExampleFragment"/>


```

The android:name attribute specifies the class name of the Fragment to instantiate. When the activity's layout is inflated, the specified fragment is instantiated, onInflate() is called on the newly instantiated fragment, and a FragmentTransaction is created to add the fragment to the FragmentManager.

Note: You can use the class attribute instead of android:name as an alternative way to specify which Fragment to instantiate.
    
    
### Add a fragment programmatically
To programmatically add a fragment to your activity's layout, the layout should include a FragmentContainerView to serve as a fragment container, as shown in the following example:

```

<!-- res/layout/example_activity.xml -->
<androidx.fragment.app.FragmentContainerView
    xmlns:android="http://schemas.android.com/apk/res/android"
    android:id="@+id/fragment_container_view"
    android:layout_width="match_parent"
    android:layout_height="match_parent" />


```

Unlike the XML approach, the android:name attribute isn't used on the FragmentContainerView here, so no specific fragment is automatically instantiated. Instead, a FragmentTransaction is used to instantiate a fragment and add it to the activity's layout.

While your activity is running, you can make fragment transactions such as adding, removing, or replacing a fragment. In your FragmentActivity, you can get an instance of the FragmentManager, which can be used to create a FragmentTransaction. Then, you can instantiate your fragment within your activity's onCreate() method using FragmentTransaction.add(), passing in the ViewGroup ID of the container in your layout and the fragment class you want to add and then commit the transaction, as shown in the following example:

```
class ExampleActivity : AppCompatActivity(R.layout.example_activity) {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        if (savedInstanceState == null) {
            supportFragmentManager.commit {
                setReorderingAllowed(true)
                add<ExampleFragment>(R.id.fragment_container_view)
            }
        }
    }
}
```

Note: You should always use setReorderingAllowed(true) when performing a FragmentTransaction.

In the previous example, note that the fragment transaction is only created when savedInstanceState is null. This is to ensure that the fragment is added only once, when the activity is first created. When a configuration change occurs and the activity is recreated, savedInstanceState is no longer null, and the fragment does not need to be added a second time, as the fragment is automatically restored from the savedInstanceState.

If your fragment requires some initial data, arguments can be passed to your fragment by providing a Bundle in the call to FragmentTransaction.add(), as shown below:

```
class ExampleActivity : AppCompatActivity(R.layout.example_activity) {
      override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        if (savedInstanceState == null) {
            val bundle = bundleOf("some_int" to 0)
            supportFragmentManager.commit {
                setReorderingAllowed(true)
                add<ExampleFragment>(R.id.fragment_container_view, args = bundle)
            }
        }
    }
}
```

The arguments Bundle can then be retrieved from within your fragment by calling requireArguments(), and the appropriate Bundle getter methods can be used to retrieve each argument.

```
class ExampleFragment : Fragment(R.layout.example_fragment) {
    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        val someInt = requireArguments().getInt("some_int")
        ...
    }
}

```
