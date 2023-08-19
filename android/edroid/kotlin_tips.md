# Kotlin Tips & Tricks  

## with() and apply()

`with()` allows you to pass a function as a parameter in which you can call members of an instance as if you were writing code within a class of this instance. Basically, instead of having this:

```kotlin
fun updateText(textView: TextView) {
    textView.visible = View.VISIBLE
    textView.text = "Hello world"
    textView.setOnClickListener {
        // Do stuff
    }
}
```

You can have like this

```kotlin
fun updateText(textView: TextView) {
  with (textView) {
    visible = View.VISIBLE
    text = "Hello world"
    setOnClickListener {
      // Do stuff
    }
  }
}
```

Not a game changer, but looks better in my opinion. Going further, if `textView` is **nullable** we can use `apply()` instead:

```kotlin
fun updateText(textView: TextView?) {
  textView?.apply {
    visible = View.VISIBLE
    text = "Hello world"
    setOnClickListener {
      // Do stuff
    }
  }
}
```

## takeUnless(), let() and elvis operator

```kotlin
override fun getItemCount(): Int {
  if (parkspot == null || parkspot.isEmpty) {
    return ITEMS_COUNT_WHEN_NO_VEHICLES
  }

  return parkspot.vehicles.size + HEADER_COUNT_WHEN_HAVING_VEHICLES
}
```

That isn’t exactly bad. But I believe we can improve it. With `takeUnless()`, `let()` and elvis operator we can do magic like that:

```kotlin
override fun getItemCount(): Int {
  return parkspot
           ?.takeUnless { it.isEmpty }
           ?.vehicles
           ?.let {
             it.size + HEADER_COUNT_WHEN_HAVING_VEHICLES
           }
           ?: ITEMS_COUNT_WHEN_NO_VEHICLES
}
```

## Overloaded operators for collections

Java-way: 

```java
fun listItemsToDisplay(): List<ListItem> {
  val result = ArrayList()
  result.add(ListItem.Header)
  result.addAll(closestVehicles())
  result.addAll(recentSearches())

  return result
}
```

Kotlin-way:

```kotlin
fun listItemsToDisplay(): List<ListItem> {
  return listOf(ListItem.Header) + closestVehicles() + recentSearches() 
}
```

## Defining a Map


```kotlin
val hashMap = HashMap<String, String>()
hashMap.put("keyA", "valueA")
hashMap.put("keyB", "valueB")
hashMap.put("keyC", "valueC")
```

Same map can be implement like bellow, no need for explicitly defining generic types and no repetitive put which just creates a visual clutter.

```kotlin
val map = mapOf(
  "keyA" to "valueA",
  "keyB" to "valueB",
  "keyC" to "valueC"
)
```
