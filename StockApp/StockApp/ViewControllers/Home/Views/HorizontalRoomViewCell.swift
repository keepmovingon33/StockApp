//
//  HorizontalRoomViewCell.swift
//  StockApp
//
//  Created by Sky on 3/7/21.
//

import UIKit

class HorizontalRoomViewCell: UITableViewCell {
    // this is tableViewCell, so it doesn't have viewWillLayoutSubview or viewDidLayoutSubview, which help the time we finish loading cell time, so that we will update the height of the cell item in this func
    
    // because UITableViewCell contains a UICollectionView, we need to calculate UITableViewCell's height. 

    @IBOutlet weak var collectionView: ContentSizedCollectionView! {
        didSet {
            collectionView.delegate = self
            collectionView.dataSource = self
            // cach padding bao nhieu
            collectionView.contentInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 0)
            // hide cai scroll horizontal
            collectionView.showsHorizontalScrollIndicator = false
        }
    }
    @IBOutlet weak var flowLayout: AlignedCollectionViewFlowLayout! {
        didSet {
            // we want to scroll horizontally
            flowLayout.scrollDirection = .horizontal
            // we calculate height of cell item. We know height of the cell item because we know the width already in JoinRoomItemViewCell
            flowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
            flowLayout.verticalAlignment = .top
        }
    }
    
    let identifier = "HorizontalRoomItemViewCell"
    
    var rooms: [Room] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        collectionView.register(UINib(nibName: identifier, bundle: nil), forCellWithReuseIdentifier: identifier)
    }
    
    func configure(rooms: [Room]) {
        self.rooms = rooms
        collectionView.reloadData()
    }
    
}

extension HorizontalRoomViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return rooms.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! HorizontalRoomItemViewCell
        cell.configure(room: rooms[indexPath.row])
        return cell
    }
}
