#### How to use it
1. Create a Swift UIView class with the code below
2. Add and place your UIView where you want
3. Then subclass your UIView with the Swift UIView class created before
4. Call to that as below

```
#!Swift
let rect = Rect(x: 20, y: 20, w: 76, h: 76)
yourView.maskLayerWith(shape: .Circle, rect: rect)
```

**Swift UIView class** :point_down:
```
#!Swift
import UIKit

enum ShapeType {
    case Rectangle
    case Circle
    case Triangle
    case Pentagon
    case All
}

struct Rect {
    var x: CGFloat
    var y: CGFloat
    var w: CGFloat
    var h: CGFloat
}

class ViewWithMaskLayer: UIView {
    
    // A function which will pick a mask to apply based on the enum thus passed. Remember that All will imply to apply all masks
    func maskLayerWith(shape: ShapeType, rect: Rect) {
        let finalPath = UIBezierPath(rect: self.bounds)
        let maskLayer = CAShapeLayer()
        maskLayer.frame = self.bounds
        
        if (shape == .Rectangle) {
            finalPath.append(self.rectanglePath(rect: rect))
        } else if (shape == .Circle) {
            finalPath.append(self.circlePath(rect: rect))
        } else if (shape == .Triangle) {
            finalPath.append(self.trianglePath())
        } else if (shape == .Pentagon) {
            finalPath.append(self.pentagonPath())
        } else if (shape == .All) {
            finalPath.append(self.rectanglePath(rect: rect))
            finalPath.append(self.circlePath(rect: rect))
            finalPath.append(self.trianglePath())
            finalPath.append(self.pentagonPath())
        }
        maskLayer.fillRule = kCAFillRuleEvenOdd
        maskLayer.path = finalPath.cgPath
        self.layer.mask = maskLayer
    }
    
    func rectanglePath(rect: Rect) -> UIBezierPath {
        let rect = CGRect(x: rect.x, y: rect.y, width: rect.w, height: rect.h)
        return UIBezierPath(rect: rect)
    }
    
    func circlePath(rect: Rect) -> UIBezierPath {
        let rect = CGRect(x: rect.x, y: rect.y, width: rect.w, height: rect.h)
        return UIBezierPath(ovalIn: rect)
    }
    
    func trianglePath() -> UIBezierPath {
        let trianglePath = UIBezierPath()
        trianglePath.move(to: CGPoint(x: self.frame.size.width/2, y: 400))
        trianglePath.addLine(to: CGPoint(x:100, y: 500))
        trianglePath.addLine(to: CGPoint(x: self.frame.size.width - 100, y: 500))
        trianglePath.close()
        return trianglePath
    }
    
    func pentagonPath() -> UIBezierPath {
        // Ref: https://developer.apple.com/library/content/documentation/2DDrawing/Conceptual/DrawingPrintingiOS/BezierPaths/BezierPaths.html
        let pentagonPath = UIBezierPath()
        // Set the starting point of the shape.
        pentagonPath.move(to: CGPoint(x: 100, y: 70))
        pentagonPath.addLine(to: CGPoint(x: 200, y: 110))
        pentagonPath.addLine(to: CGPoint(x: 160, y: 210))
        pentagonPath.addLine(to: CGPoint(x: 40, y: 210))
        pentagonPath.addLine(to: CGPoint(x: 0, y: 110))
        pentagonPath.close()
        return pentagonPath
    }
}
```