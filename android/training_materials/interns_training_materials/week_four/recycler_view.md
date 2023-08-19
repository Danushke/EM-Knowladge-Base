# Create dynamic lists with RecyclerView

## What is RecyclerView?

RecyclerView is the ViewGroup that contains the views corresponding to your data. It's a view itself, so you add RecyclerView into your layout the way you would add any other UI element.
RecyclerView makes it easy to efficiently display large sets of data. You supply the data and define how each item looks, and the RecyclerView library dynamically creates the elements when they're needed.
As the name implies, RecyclerView recycles those individual elements. When an item scrolls off the screen, RecyclerView doesn't destroy its view. Instead, RecyclerView reuses the view for new items that have scrolled onscreen. This reuse vastly improves performance, improving your app's responsiveness and reducing power consumption.

## Key classes
Several different classes work together to build your dynamic list.

* **ViewHolder**
Each individual element in the list is defined by a view holder object.
When the view holder is created, it doesn't have any data associated with it.
After the view holder is created, the RecyclerView binds it to its data.
You define the view holder by extending RecyclerView.ViewHolder.

* **Adapter**
The RecyclerView requests those views, and binds the views to their data, by calling methods in the adapter. You define the adapter by extending RecyclerView.Adapter.

* **LayoutManager**
The layout manager arranges the individual elements in your list. You can use one of the layout managers provided by the RecyclerView library, or you can define your own.
Layout managers are all based on the library's LayoutManager abstract class.

## Steps for implementing your RecyclerView

### 1. Plan your layout

The items in your RecyclerView are arranged by a LayoutManager class. The RecyclerView library provides three layout managers, which handle the most common layout situations:

* **LinearLayoutManager** arranges the items in a one-dimensional list.
* **GridLayoutManager** arranges all items in a two-dimensional grid:

  1) If the grid is arranged vertically, GridLayoutManager tries to make all the elements in each row have the same width and height, but different rows can have different heights.
  2) If the grid is arranged horizontally, GridLayoutManager tries to make all the elements in each column have the same width and height, but different columns can have different widths.

* **StaggeredGridLayoutManager** is similar to GridLayoutManager, but it does not require that items in a row have the same height (for vertical grids) or items in the same column have the same width (for horizontal grids). The result is that the items in a row or column can end up offset from each other.

### 2. Implementing your adapter and view holder

Once you've determined your layout, you need to implement your Adapter and ViewHolder. These two classes work together to define how your data is displayed. The ViewHolder is a wrapper around a View that contains the layout for an individual item in the list. The Adapter creates ViewHolder objects as needed, and also sets the data for those views. The process of associating views to their data is called binding.

When you define your adapter, you need to override three key methods:

* **onCreateViewHolder():** RecyclerView calls this method whenever it needs to create a new ViewHolder. The method creates and initializes the ViewHolder and its associated View, but does not fill in the view's contents—the ViewHolder has not yet been bound to specific data.

* **onBindViewHolder():** RecyclerView calls this method to associate a ViewHolder with data. The method fetches the appropriate data and uses the data to fill in the view holder's layout. For example, if the RecyclerView displays a list of names, the method might find the appropriate name in the list and fill in the view holder's TextView widget.

* **getItemCount():** RecyclerView calls this method to get the size of the data set. For example, in an address book app, this might be the total number of addresses. RecyclerView uses this to determine when there are no more items that can be displayed.


```
class CustomAdapter(private val dataSet: Array<String>) :
        RecyclerView.Adapter<CustomAdapter.ViewHolder>() {

    /**
     * Provide a reference to the type of views that you are using
     * (custom ViewHolder).
     */
    class ViewHolder(view: View) : RecyclerView.ViewHolder(view) {
        val textView: TextView

        init {
            // Define click listener for the ViewHolder's View.
            textView = view.findViewById(R.id.textView)
        }
    }

    // Create new views (invoked by the layout manager)
    override fun onCreateViewHolder(viewGroup: ViewGroup, viewType: Int): ViewHolder {
        // Create a new view, which defines the UI of the list item
        val view = LayoutInflater.from(viewGroup.context)
                .inflate(R.layout.text_row_item, viewGroup, false)

        return ViewHolder(view)
    }

    // Replace the contents of a view (invoked by the layout manager)
    override fun onBindViewHolder(viewHolder: ViewHolder, position: Int) {

        // Get element from your dataset at this position and replace the
        // contents of the view with that element
        viewHolder.textView.text = dataSet[position]
    }

    // Return the size of your dataset (invoked by the layout manager)
    override fun getItemCount() = dataSet.size

}
```
The layout for the each view item is defined in an XML layout file, as usual. In this case, the app has a text_row_item.xml file like this:

```
<FrameLayout xmlns:android="http://schemas.android.com/apk/res/android"
    android:layout_width="match_parent"
    android:layout_height="@dimen/list_item_height"
    android:layout_marginLeft="@dimen/margin_medium"
    android:layout_marginRight="@dimen/margin_medium"
    android:gravity="center_vertical">

    <TextView
        android:id="@+id/textView"
        android:layout_width="wrap_content"
        android:layout_height="wrap_content"
        android:text="@string/element_text"/>
</FrameLayout>


```

## Add item animations

* Whenever an item changes, the RecyclerView uses an animator to change its appearance. This animator is an object that extends the abstract RecyclerView.ItemAnimator class. By default, the RecyclerView uses DefaultItemAnimator to provide the animation. If you want to provide custom animations, you can define your own animator object by extending RecyclerView.ItemAnimator.

## Enable list-item selection

* The recyclerview-selection library enables users to select items in RecyclerView list using touch or mouse input. You retain control over the visual presentation of a selected item. You can also retain control over policies controlling selection behavior, such as items that can be eligible for selection, and how many items can be selected.
To add selection support to a RecyclerView instance, follow these steps:

**1. Determine which selection key type to use, then build a ItemKeyProvider**
There are three key types that you can use to identify selected items: Parcelable (and all subclasses like Uri), String, and Long. For detailed information about selection-key types, see SelectionTracker.Builder.

**2. Implement ItemDetailsLookup.**
ItemDetailsLookup enables the selection library to access information about RecyclerView items given a MotionEvent. It is effectively a factory for ItemDetails instances that are backed up by (or extracted from) a RecyclerView.ViewHolder instance.

**3. Update item Views in RecyclerView to reflect that the user has selected or unselected it.**
The selection library does not provide a default visual decoration for the selected items. You must provide this when you implement onBindViewHolder(). The recommended approach is as follows:

* In onBindViewHolder(), call setActivated() (not setSelected()) on the View object with true or false (depending on if the item is selected).
* Update the styling of the view to represent the activated status. We recommend you use a color state list resource to configure the styling.

**4. Use ActionMode to provide the user with tools to perform an action on the selection.**
Register a SelectionTracker.SelectionObserver to be notified when selection changes. When a selection is first created, start ActionMode to represent this to the user, and provide selection-specific actions. For example, you may add a delete button to the ActionMode bar, and connect the back arrow on the bar to clear the selection. When the selection becomes empty (if the user cleared the selection the last time), don't forget to terminate action mode.

**5. Perform any interpreted secondary actions**
At the end of the event processing pipeline, the library may determine that the user is attempting to activate an item by tapping it, or is attempting to drag and drop an item or set of selected items. React to these interpretations by registering the appropriate listener. For more information, see SelectionTracker.Builder.

**6.Assemble everything with SelectionTracker.Builder**
The following example shows how to put these pieces together by using the Long selection key:

```
var tracker = SelectionTracker.Builder(
    "my-selection-id",
    recyclerView,
    StableIdKeyProvider(recyclerView),
    MyDetailsLookup(recyclerView),
    StorageStrategy.createLongStorage())
        .withOnItemActivatedListener(myItemActivatedListener)
        .build()
```
In order to build a SelectionTracker instance, your app must supply the same RecyclerView.Adapter that you used to initialize RecyclerView to SelectionTracker.Builder. For this reason, you will most likely need to inject the SelectionTracker instance, once created, into your RecyclerView.Adapter after the RecyclerView.Adapter is created. Otherwise, you won't be able to check an item's selected status from the onBindViewHolder() method.

**7. Include selection in the activity lifecycle events**

In order to preserve selection state across the activity lifecycle events, your app must call the selection tracker's onSaveInstanceState() and onRestoreInstanceState() methods from the activity's onSaveInstanceState() and onRestoreInstanceState() methods respectively. Your app must also supply a unique selection ID to the SelectionTracker.Builder constructor. This ID is required because an activity or a fragment may have more than one distinct, selectable list, all of which need to be persisted in their saved state.

