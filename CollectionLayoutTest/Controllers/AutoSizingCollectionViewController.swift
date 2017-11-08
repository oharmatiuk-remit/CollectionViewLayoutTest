//
//  CollectionViewController.swift
//  CollectionLayoutTest
//
//  Created by O.Harmatiuk on 10/12/17.
//  Copyright © 2017 O.Harmatiuk. All rights reserved.
//

import UIKit

private let reuseIdentifier = "AutoSizingCollectionViewCell"

class AutoSizingCollectionViewController: UICollectionViewController {
    
    private var generator = LoremIpsumGenerator()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let layout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout {
            //layout.estimatedItemSize = CGSize(width: 100, height: 100)
            layout.estimatedItemSize = UICollectionViewFlowLayoutAutomaticSize
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        print(items: "will display cell #\(indexPath.item)")
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10000
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
        
        guard let customCell = cell as? AutoSizingCollectionViewCell else { return cell }
        
        customCell.titleLabel.text = "Cell \(indexPath.item)"
        customCell.descriptionLabel.text = "Section #\(indexPath.section), row #\(indexPath.item)"
        
        let randomMultiplier = Int(arc4random_uniform(5)) + 1
        customCell.longTextLabel.text = generator.createPhrase((1 + indexPath.item) * randomMultiplier)
    
        return cell
    }
}

extension AutoSizingCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 320, height: 100)
    }
}
