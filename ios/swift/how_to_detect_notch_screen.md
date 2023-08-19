### Extension
```
#!Swift
extension UIDevice {
    var hasNotch: Bool {
        let bottom = UIApplication.shared.keyWindow?.safeAreaInsets.bottom ?? 0
        return bottom > 0
    }
}
```

### How to use it
```
#!Swift
if UIDevice.current.hasNotch {
    //... consider notch 
} else {
    //... don't have to consider notch 
}
```

###References
- https://medium.com/@cafielo/how-to-detect-notch-screen-in-swift-56271827625d
- https://stackoverflow.com/questions/46829840/get-safe-area-inset-top-and-bottom-heights