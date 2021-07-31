//
//  NewsDetailsViewController.swift
//  Asgatech Task
//
//  Created by Shorouk Mohamed on 7/29/21.
//  Copyright © 2021 Shorouk Mohamed. All rights reserved.
//

import UIKit
import Kingfisher
import WebKit

class NewsDetailsViewController: UIViewController {
    
    var articleTitle = ""
    var articleDescription = ""
    var articleContent = ""
    var articleAuthor = ""
    var articleDate = ""
    var articleName = ""
    var articleURL = ""
    var articleImg = ""
    
    @IBOutlet weak var articleImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = false
        navigationItem.title = articleName
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.red]
        
    }
    
    @IBAction func goToArticleSourceBtn(_ sender: Any) {
        let webViewVC = WebViewVC()
        webViewVC.urlString = articleURL
        self.navigationController?.pushViewController(webViewVC, animated: true)
        
        
    }
    
    private func setupData(){
        setupImage()
        setupContentString()
        setupLabels()
    }
    
    private func setupImage(){
        let url = URL(string: articleImg)
        let placeholder = UIImage(named: "newsplaceholder")
        articleImage.kf.indicatorType = .activity
        articleImage.kf.setImage(with: url, placeholder: placeholder, options: [], progressBlock: nil) { _ in
        }
    }
    
    private func setupLabels(){
        titleLabel.text = articleTitle
        descriptionLabel.text = articleDescription
        contentLabel.text = articleContent
        authorLabel.text = articleAuthor
        dateLabel.text = articleDate.handleDate()
    }
    
    private func setupContentString(){
        guard let beginIndex = articleContent.firstIndex(of: "[") , let lastIndex = articleContent.firstIndex(of: "]") else {return}
        articleContent.removeSubrange(beginIndex...lastIndex)
    }
}
