
//
//  NewsViewController+CollectionView.swift
//  Asgatech Task
//
//  Created by Shorouk Mohamed on 7/28/21.
//  Copyright © 2021 Shorouk Mohamed. All rights reserved.
//

import UIKit

extension NewsViewController: UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout, UICollectionViewDataSourcePrefetching{
    
    
    func setUpCollectionView() {
        NewsCollectionView.delegate = self
        NewsCollectionView.dataSource = self
        NewsCollectionView.prefetchDataSource = self
        NewsCollectionView.register(UINib(nibName: "NewsCell", bundle: nil ), forCellWithReuseIdentifier: "NewsCell")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return newsPresenter?.getNewsArrayCount() ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NewsCell", for: indexPath) as! NewsCell
        newsPresenter?.configureCell(cell: cell, indexPath: indexPath.row)
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if newsPresenter?.getArticles()[indexPath.item].title != ""{
            let approximateWidth = view.frame.width
            let size = CGSize(width: approximateWidth, height: CGFloat.greatestFiniteMagnitude)
            let estimatedFrame = NSString(string: newsPresenter?.getArticles()[indexPath.item].title ?? "").boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: [.font: UIFont.systemFont(ofSize: 18)], context: nil)
            return CGSize(width: collectionView.frame.size.width - 10, height: estimatedFrame.height + 240)
        }else{
            return CGSize(width: collectionView.frame.size.width - 10, height: 240)
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        for index in indexPaths{
            if index.row >= ((newsPresenter?.getNewsArrayCount())!)  - 3 && !isFetchingData{
                newsPresenter?.getNews()
                break
                
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let newsDetailsVC = NewsDetailsViewController()
        newsDetailsVC.articleTitle = newsPresenter?.getArticles()[indexPath.row].title ?? ""
        newsDetailsVC.articleDescription = newsPresenter?.getArticles()[indexPath.row].articleDescription ?? ""
        newsDetailsVC.articleContent = newsPresenter?.getArticles()[indexPath.row].content ?? ""
        newsDetailsVC.articleAuthor = newsPresenter?.getArticles()[indexPath.row].author ?? ""
        newsDetailsVC.articleDate = (newsPresenter?.getArticles()[indexPath.row].publishedAt ?? "").handleDate()
        newsDetailsVC.articleName = newsPresenter?.getArticles()[indexPath.row].source.name ?? ""
        newsDetailsVC.articleURL = newsPresenter?.getArticles()[indexPath.row].url ?? "https://www.google.com"
        newsDetailsVC.articleImg = newsPresenter?.getArticles()[indexPath.row].urlToImage ?? ""


        self.navigationController?.pushViewController(newsDetailsVC, animated: true)
        
    }
    
 
    
}


