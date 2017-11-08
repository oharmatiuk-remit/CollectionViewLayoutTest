//
//  FeaturedCollectionViewCell.swift
//  CollectionLayoutTest
//
//  Created by O.Harmatiuk on 10/17/17.
//  Copyright © 2017 O.Harmatiuk. All rights reserved.
//

import UIKit

class FeaturedCollectionViewCell: UICollectionViewCell {
    
    var actionCallback:(()->())?
    
    @IBOutlet weak var mainContainer: UIView!
    @IBOutlet weak var widthConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var labelContainer: UIView!
    var labels:[UILabel] = []
    
    var expectedSize:CGSize?
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var emptyView: UIView!
    
    @IBOutlet weak var actionButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    
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
    }
    
    override func apply(_ layoutAttributes: UICollectionViewLayoutAttributes) {
        super.apply(layoutAttributes)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        print(items:#function)
        for label in labels {
            label.removeFromSuperview()
        }
        labels.removeAll()
        expectedSize = nil
    }
    
    func setupStackView(with strings:[String]) {
        
        for (index, string) in strings.enumerated() {
            
            let label = UILabel()
            
            label.numberOfLines = 0
            label.preferredMaxLayoutWidth = widthConstraint!.constant
            
//            translatesAutoresizingMaskIntoConstraints = false
            label.translatesAutoresizingMaskIntoConstraints = false
//            mainContainer.translatesAutoresizingMaskIntoConstraints = false
//            labelContainer.translatesAutoresizingMaskIntoConstraints = false
            
            labels.append(label)
            labelContainer.addSubview(label)
            
            if index == 0 {
                label.topAnchor.constraint(equalTo: labelContainer.topAnchor, constant: 10.0).isActive = true
            } else {
                label.topAnchor.constraint(equalTo: (labels[index-1]).bottomAnchor, constant: 10.0).isActive = true
            }
            
            label.leadingAnchor.constraint(equalTo: labelContainer.leadingAnchor).isActive = true
            label.trailingAnchor.constraint(equalTo: labelContainer.trailingAnchor).isActive = true
            
            if string == strings.last {
               labelContainer.bottomAnchor.constraint(equalTo: label.bottomAnchor, constant: 30.0).isActive = true
            }
            
            label.text = "- ".appending(string.lowercased())
        }
    }
    @IBAction func actionButtonTap(_ sender: Any) {
        actionCallback?()
    }
    
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        print(#function)
        var frame = layoutAttributes.frame
        frame.size = mainContainer.systemLayoutSizeFitting(UILayoutFittingCompressedSize)
        layoutAttributes.frame = frame
        
        return layoutAttributes
    }
    
}
