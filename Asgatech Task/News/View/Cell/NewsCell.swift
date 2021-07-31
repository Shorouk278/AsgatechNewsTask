//
//  NewsCell.swift
//  Asgatech Task
//
//  Created by Shorouk Mohamed on 7/28/21.
//  Copyright © 2021 Shorouk Mohamed. All rights reserved.
//

import UIKit
import Kingfisher


protocol NewsCellProtocol{
    func configureCell(title:String, image: String, source: String)
}

class NewsCell: UICollectionViewCell, NewsCellProtocol{

    @IBOutlet weak var newsSource: UILabel!
    @IBOutlet weak var newsImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
      override func layoutSubviews() {
            self.contentView.layer.cornerRadius = 8.0
            self.contentView.layer.borderWidth = 1.0
            self.contentView.layer.borderColor = UIColor.clear.cgColor
            self.contentView.layer.masksToBounds = true

            self.layer.shadowColor = UIColor.gray.cgColor
            self.layer.shadowOffset = CGSize(width: 0, height: 2.0)
            self.layer.shadowRadius = 2.0
            self.layer.shadowOpacity = 1.0
            self.layer.masksToBounds = false
       


        }
    func configureCell(title: String, image: String, source: String) {
        titleLabel.text = title
        let url = URL(string: image)
        let placeholder = UIImage(named: "newsplaceholder")
        newsImage.kf.indicatorType = .activity
        newsImage.kf.setImage(with: url, placeholder: placeholder, options: [], progressBlock: nil) { _ in
              }
        newsSource.text = source

}
     
     
}
