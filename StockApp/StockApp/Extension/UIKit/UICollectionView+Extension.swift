//
//  UICollectionView+Extension.swift
//  StockApp
//
//  Created by Sky on 3/7/21.
//

import UIKit

final class ContentSizedCollectionView: UICollectionView {
    // ham nay la height cua collectionview = size cua collectionview items
    override var intrinsicContentSize: CGSize {
        return self.collectionViewLayout.collectionViewContentSize
    }
    
    override func reloadData() {
        super.reloadData()
        // khi minh goi reload data no van chay dung
        self.invalidateIntrinsicContentSize()
    }
}
