```
#!Swift
import UIKit

class AttributedButton: UIButton {

    override public func awakeFromNib() {
        super.awakeFromNib()

    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        
        if let image = self.imageView?.image {
            
            let margin = 22 - image.size.width / 2
            let titleRec = titleRect(forContentRect: bounds)
            _ = (bounds.width - titleRec.width - image.size.width - margin) / 2
            
            contentHorizontalAlignment = UIControlContentHorizontalAlignment.left
            imageEdgeInsets = UIEdgeInsetsMake(0, margin, 0, 0)
            titleEdgeInsets = UIEdgeInsetsMake(0, (bounds.width - titleRec.width -  image.size.width - margin) / 2, 0, 0)
        }
    }
}
```