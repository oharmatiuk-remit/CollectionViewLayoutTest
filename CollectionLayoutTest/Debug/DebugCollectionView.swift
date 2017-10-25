//
//  DebugCollectionView.swift
//  CollectionLayoutTest
//
//  Created by O.Harmatiuk on 10/17/17.
//  Copyright © 2017 O.Harmatiuk. All rights reserved.
//

import UIKit

class DebugCollectionView: UICollectionView {
    private var lastLayoutDate:Date = Date()
    private var lastContentOffset:CGFloat = 0.0
    
    override func layoutSubviews() {
        let currentDate = Date()
        
        let diff = (currentDate.timeIntervalSince1970 - lastLayoutDate.timeIntervalSince1970) * 1000
        let dateString = String(format: "%.2f", diff)
        var output = "\(#function) [\(dateString)]"
        
        let decelerationSpeed = contentOffset.y - lastContentOffset
        if diff > 33.33, decelerationSpeed > 1.0 {
            output.append("<----- LAG")
            print(items: output)
        }
        
        
        super.layoutSubviews()
        lastLayoutDate = currentDate
        lastContentOffset = contentOffset.y
    }
}
