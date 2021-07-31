//
//  NewsViewController.swift
//  Asgatech Task
//
//  Created by Shorouk Mohamed on 7/28/21.
//  Copyright © 2021 Shorouk Mohamed. All rights reserved.
//


import UIKit

protocol NewsViewProtocol{
    func reloadData()
    func showProgress()
    func hideProgress()
    func showError(message: String)
    func fetchData(isFetching: Bool)
    func setupConnectionError()
    func setupNoData()
}

class NewsViewController: UIViewController, NewsViewProtocol{
    
        
    @IBOutlet weak var NewsCollectionView: UICollectionView!
    @IBOutlet weak var retryButton: UIButton!
    @IBOutlet weak var newsSearchBar: UISearchBar!
    
    let button = UIButton()
    let noInternetConnectionLabel = UILabel()
    let searchController = UISearchController(searchResultsController: nil)
    var newsPresenter : NewsPresenterProtocol?
    var isFetchingData = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupRetryButton()
        setupNoConnectionLabel()
        newsPresenter = NewsPresenter(service: APIService(), view: self)
        newsPresenter?.getNews()
        setUpCollectionView()
        manageSearchBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
    }
    
    private func setupRetryButton(){
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .black
        button.setTitle("Retry", for: .normal)
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 8
        self.view.addSubview(button)
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            button.heightAnchor.constraint(equalToConstant: 50),
            button.widthAnchor.constraint(equalToConstant: 100)
        ])
        button.isHidden = true
    }
    
    private func setupNoConnectionLabel(){
        noInternetConnectionLabel.translatesAutoresizingMaskIntoConstraints = false
        noInternetConnectionLabel.text = "No internet connection"
        noInternetConnectionLabel.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        self.view.addSubview(noInternetConnectionLabel)
        NSLayoutConstraint.activate([
            noInternetConnectionLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            noInternetConnectionLabel.bottomAnchor.constraint(equalTo:button.topAnchor, constant: -10),
        ])
        noInternetConnectionLabel.isHidden = true
    }
    
    func reloadData() {
        removeNoConnectionView()
        showCollectionView()
        NewsCollectionView.reloadData()
    }
    
    func showProgress() {
        showIndicator()
    }
    
    func showError(message: String) {
        showAlert(view: self, message: message)
    }
    
    func hideProgress(){
        hideIndicator()
    }
    
    func showCollectionView() {
        NewsCollectionView.isHidden = false
    }
    
    func hideCollectionView() {
        NewsCollectionView.isHidden = true
    }
    
    func setupConnectionError() {
        hideCollectionView()
        showNoConnectionView()
    }
    
    func setupNoData() {
        showCollectionView()
        NewsCollectionView.setEmptyMessage("There is no avaialble data", collectionView: NewsCollectionView)
    }
    
    func removeNoConnectionView(){
        newsSearchBar.isHidden = false
        noInternetConnectionLabel.isHidden = true
        button.isHidden = true
    }
    
    func fetchData(isFetching: Bool){
          isFetchingData = isFetching
    }
    
    func showNoConnectionView() {
        newsSearchBar.isHidden = true
        noInternetConnectionLabel.isHidden = false
        button.isHidden = false
    }
    
    @objc func buttonAction(sender: UIButton!) {
            self.newsPresenter?.getNews()
    }
    
}

