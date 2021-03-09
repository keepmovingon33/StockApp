//
//  HomeBrokerViewCell.swift
//  StockApp
//
//  Created by Sky on 3/8/21.
//

import UIKit

class HomeBrokerViewCell: UITableViewCell {

    
    @IBOutlet weak var collectionView: ContentSizedCollectionView! {
        didSet {
            collectionView.delegate = self
            collectionView.dataSource = self
            collectionView.contentInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 0)
            collectionView.showsHorizontalScrollIndicator = false
        }
    }
    
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout! {
        didSet {
            flowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
            flowLayout.scrollDirection = .horizontal
        }
    }
    
    let brokerIdentifier = "BrokerItemViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        collectionView.register(UINib(nibName: brokerIdentifier, bundle: nil), forCellWithReuseIdentifier: brokerIdentifier)
    }

}

extension HomeBrokerViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: brokerIdentifier, for: indexPath) as! BrokerItemViewCell
        cell.configure()
        return cell
    }
}
