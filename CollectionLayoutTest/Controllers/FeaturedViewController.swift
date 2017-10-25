//
//  ViewController.swift
//  CollectionLayoutTest
//
//  Created by O.Harmatiuk on 10/12/17.
//  Copyright © 2017 O.Harmatiuk. All rights reserved.
//

import UIKit

class FeaturedViewController: UIViewController, UICollectionViewDataSourcePrefetching {
    fileprivate let reuseIdentifier = "FeaturedCollectionViewCell"
    
    private var generator = LoremIpsumGenerator()
    
    fileprivate var phrases:[String] = []
    
    @IBOutlet weak var collectionView: DebugCollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let layout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.estimatedItemSize = CGSize(width: 180, height: 100)
        }
        
        let cellNibName = "FeaturedCollectionViewCell"
        let nib = UINib(nibName: cellNibName, bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: reuseIdentifier)
        
        for index in 1...100 {
            let randomMultiplier = Int(arc4random_uniform(UInt32(index))) + 5
            phrases.append(generator.createPhrase((randomMultiplier)))
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        print("Prefetching for \(indexPaths)")
    }
    
    func collectionView(_ collectionView: UICollectionView, cancelPrefetchingForItemsAt indexPaths: [IndexPath]) {
        print("Cancel prefetching for \(indexPaths)")
    }
}


extension FeaturedViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        print(items:"\(#function) #\(indexPath.item)")
    }
}

extension FeaturedViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1000
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
        cell.tag = indexPath.item
        guard let customCell = cell as? FeaturedCollectionViewCell else { return cell }
        print(items: "\n\n\n\n")
        measure(label: "cell #\(indexPath.item) setup") {
            customCell.titleLabel.text = "Cell \(indexPath.item)"
            customCell.emptyView.backgroundColor = UIColor.randomColor()
            
            let randomMultiplier = Int(arc4random_uniform(10)) + 5
            customCell.setupStackView(with: phrases.prefix(upTo: randomMultiplier).reversed())
            
            measure(label: "cell size calculation") {
                customCell.expectedSize = customCell.systemLayoutSizeFitting(UILayoutFittingCompressedSize)
            }
        }
        return cell
    }
}

