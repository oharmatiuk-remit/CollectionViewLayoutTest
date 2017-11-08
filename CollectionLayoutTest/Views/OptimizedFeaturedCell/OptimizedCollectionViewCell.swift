//
//  FeaturedCollectionViewCell.swift
//  CollectionLayoutTest
//
//  Created by O.Harmatiuk on 10/17/17.
//  Copyright © 2017 O.Harmatiuk. All rights reserved.
//

import UIKit

class OptimizedCollectionViewCell: UICollectionViewCell {
    
    var actionCallback:(()->())?
    
    @IBOutlet weak var mainContainer: UIView!
    @IBOutlet weak var widthConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var labelContainer: UIView!
    var labels:[UILabel] = []
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var emptyView: UIView!
    
    @IBOutlet weak var actionButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    
    @IBOutlet weak var frameLabel: UILabel!
    @IBOutlet weak var longTextLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        applyStyle()
    }

    private func applyStyle() {
        let cornerRadius:CGFloat = 5.0
        
        emptyView.clipsToBounds = true
        actionButton.clipsToBounds = true
        cancelButton.clipsToBounds = true
        
        emptyView.layer.cornerRadius = cornerRadius
        actionButton.layer.cornerRadius = cornerRadius
        cancelButton.layer.cornerRadius = cornerRadius
        
        mainContainer.translatesAutoresizingMaskIntoConstraints = false
    }
    
    override func apply(_ layoutAttributes: UICollectionViewLayoutAttributes) {
        super.apply(layoutAttributes)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        //print(items:#function)
        for label in labels {
            label.removeFromSuperview()
        }
        labels.removeAll()
//        setNeedsLayout()
    }
    
    func setupStackView(with strings:[String]) {
        
        for (index, string) in strings.enumerated() {
            
            let label = UILabel()
            label.text = "- ".appending(string.lowercased())
            label.numberOfLines = 0
            label.preferredMaxLayoutWidth = widthConstraint.constant - 30
            
            label.translatesAutoresizingMaskIntoConstraints = false
            
            labels.append(label)
            labelContainer.addSubview(label)
            
            if index == 0 {
                labelContainer.topAnchor.constraint(equalTo:label.topAnchor, constant: 0.0).isActive = true
            } else {
                label.topAnchor.constraint(equalTo: (labels[index-1]).bottomAnchor, constant: 10.0).isActive = true
            }
            
            label.leadingAnchor.constraint(equalTo: labelContainer.leadingAnchor).isActive = true
            label.trailingAnchor.constraint(equalTo: labelContainer.trailingAnchor).isActive = true
            
            if string == strings.last {
               label.bottomAnchor.constraint(equalTo:labelContainer.bottomAnchor, constant: 0.0).isActive = true
            }
        }
    }
    
    @IBAction func actionButtonTap(_ sender: Any) {
        actionCallback?()
    }
    
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
//        //print(#function)
        return layoutAttributes
    }
}
