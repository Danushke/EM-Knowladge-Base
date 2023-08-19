//
//  LeftAlignedCollectionViewFlowLayout.swift
//  AceTradies
//
//  Created by Kasun Sandeep on 10/18/19.
//  Copyright © 2019 ElegantMedia. All rights reserved.
//

import UIKit

class LeftAlignedCollectionViewFlowLayout: UICollectionViewFlowLayout {
    var font: UIFont = UIFont.systemFont(ofSize: 16)
    var certificate: [String] = []
    var callback: HeightCallback?
    var fixedSpacing: CGFloat = 0
    var cellHeight: CGFloat = 44

    public init(certificate: [String], font: UIFont, cellHeight: CGFloat, fixedSpacing: CGFloat, callback:@escaping HeightCallback) {
        super.init()
        
        self.callback = callback
        self.certificate = certificate
        self.font = font
        self.fixedSpacing = fixedSpacing
        self.cellHeight = cellHeight
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        guard let attributes = super.layoutAttributesForElements(in: rect), let collectionViewWidth = collectionView?.frame.size.width, attributes.count > 0 else {
            callback?(1)
            return nil
        }

        var leftMargin = sectionInset.left
        var topMargin = sectionInset.top
        
        for idx in 0...(attributes.count - 1) {
            let textBounding: CGSize = certificate[idx].size(withAttributes: [.font: font])
            let itemWidth = textBounding.width + fixedSpacing
            
            if leftMargin == sectionInset.left, idx != 0 {
                topMargin += cellHeight + minimumInteritemSpacing
            }
            
            attributes[idx].frame.origin.x = leftMargin
            attributes[idx].frame.size.width = itemWidth
            attributes[idx].frame.size.height = cellHeight

            leftMargin += attributes[idx].frame.width + minimumInteritemSpacing
            
            if leftMargin >= collectionViewWidth {
                topMargin += cellHeight + minimumInteritemSpacing
                
                leftMargin = sectionInset.left
                attributes[idx].frame.origin.x = leftMargin
                
                if itemWidth > collectionViewWidth {
                    attributes[idx].frame.size.width = collectionViewWidth
                } else {
                    leftMargin += attributes[idx].frame.width + minimumInteritemSpacing
                }
            }
            
            attributes[idx].frame.origin.y = topMargin
        }
        
        callback?(topMargin + 36)
        callback = nil

        return attributes
    }
}
