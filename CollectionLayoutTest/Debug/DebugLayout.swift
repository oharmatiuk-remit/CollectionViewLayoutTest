//
//  DebugLayout.swift
//  CollectionLayoutTest
//
//  Created by O.Harmatiuk on 10/17/17.
//  Copyright © 2017 O.Harmatiuk. All rights reserved.
//

import UIKit

class DebugLayout: UICollectionViewFlowLayout {

    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        //print(items:#function)
        return super.layoutAttributesForItem(at: indexPath)
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        //print(items:#function)
        let attributes = super.layoutAttributesForElements(in: rect)!
        let sizes = attributes.map({ attributes in return String(describing:attributes.frame.size) })
        //print(sizes.joined(separator: ","))
        return attributes
    }
    
    override var estimatedItemSize: CGSize {
        didSet {
            //print(items:"Changed estimatedItemSize to : \(estimatedItemSize)")
        }
    }
    
    override func prepare() {
        //print(items:#function)
        super.prepare()
    }
    
    override var collectionViewContentSize: CGSize {
        let contentSize = super.collectionViewContentSize
        //print(items:"\(#function): \(contentSize)")
        return contentSize
    }
    
    override func invalidateLayout() {
        //print(items:#function)
        super.invalidateLayout()
    }
    
    override func invalidateLayout(with context: UICollectionViewLayoutInvalidationContext) {
        //print(items:#function)
        super.invalidateLayout(with: context)
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        //print(items:#function)
        return super.shouldInvalidateLayout(forBoundsChange: newBounds)
    }
}
