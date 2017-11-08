//
//  FeaturedCollectionViewCell.swift
//  CollectionLayoutTest
//
//  Created by O.Harmatiuk on 10/17/17.
//  Copyright © 2017 O.Harmatiuk. All rights reserved.
//

import UIKit

class HeavyFeaturedCell: UICollectionViewCell {
    
    var actionCallback:(()->())?
    
    @IBOutlet weak var mainContainer: UIView!
    @IBOutlet weak var widthConstraint: NSLayoutConstraint!
    @IBOutlet weak var stackView: UIStackView!
    
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
        print(items:"\(#function):\(layoutAttributes.frame)")
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
            
            stackView.addArrangedSubview(label)
            
            label.text = "- ".appending(string.lowercased())
        }
    }
    
    @IBAction func actionButtonTap(_ sender: Any) {
        actionCallback?()
    }
    
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        let oldFrame = layoutAttributes.frame
        var frame = layoutAttributes.frame
        let oldHeight = oldFrame.size.height
        
        frame.size = mainContainer.systemLayoutSizeFitting(UILayoutFittingCompressedSize)
        layoutAttributes.frame = frame
        
        print(items:"\(#function): \(oldHeight)->\(layoutAttributes.frame.size.height)")
        return layoutAttributes
    }
}
