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
            collectionView.contentInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
            collectionView.showsHorizontalScrollIndicator = false
        }
    }
    
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout! {
        didSet {
            flowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
            flowLayout.scrollDirection = .horizontal
            
            flowLayout.minimumLineSpacing = 16
            flowLayout.minimumInteritemSpacing = 16
        }
    }
    
    let brokerIdentifier = "BrokerItemViewCell"
    // minh gop brokers va user la nhu nhau
    var brokers: [User] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        collectionView.register(UINib(nibName: brokerIdentifier, bundle: nil), forCellWithReuseIdentifier: brokerIdentifier)
    }
    
    func configure(brokers: [User]) {
        self.brokers = brokers
        collectionView.reloadData()
    }

}

extension HomeBrokerViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return brokers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: brokerIdentifier, for: indexPath) as! BrokerItemViewCell
        cell.configure(user: brokers[indexPath.row])
        return cell
    }
}
