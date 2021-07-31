//
//  CollectionViewExtension.swift
//  Asgatech Task
//
//  Created by Shorouk Mohamed on 7/28/21.
//  Copyright © 2021 Shorouk Mohamed. All rights reserved.
//

import UIKit

extension UICollectionView{
    
    func setEmptyMessage(_ message: String, collectionView: UICollectionView) {
        let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: 30))
        messageLabel.text = message
        messageLabel.textColor = .black
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        messageLabel.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        messageLabel.sizeToFit()
        messageLabel.clipsToBounds = true
        self.backgroundView = messageLabel
    }
    
}


