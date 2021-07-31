//
//  NewsViewController+SearchBar.swift
//  Asgatech Task
//
//  Created by Shorouk Mohamed on 7/29/21.
//  Copyright © 2021 Shorouk Mohamed. All rights reserved.
//

import UIKit

extension NewsViewController: UISearchBarDelegate{

    func manageSearchBar(){
        newsSearchBar.delegate = self
        newsSearchBar.layer.cornerRadius = 5
        newsSearchBar.layer.shadowColor = UIColor.lightGray.cgColor
        newsSearchBar.layer.borderColor = .none
        newsSearchBar.placeholder = "Search for news..."
        if let searchTextField = self.newsSearchBar.value(forKey: "searchField") as? UITextField , let clearButton = searchTextField.value(forKey: "_clearButton")as? UIButton {
            clearButton.addTarget(self, action: #selector(onClearButtonPressed), for: .touchUpInside)
        }
    }
    
    
    @objc func onClearButtonPressed(){
        newsSearchBar.endEditing(true)
    }
   
   

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        newsSearchBar.endEditing(true)
        newsPresenter?.filterNews(searchText: searchBar.text ?? "")
        newsPresenter?.setNewsSearchState(.filter)
    }
  
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == "" {
        newsPresenter?.filterNews(searchText: "")
        newsPresenter?.setNewsSearchState(.all)
        newsSearchBar.endEditing(true)
        }
    }
    
    var searchState: SearchState {
        return (newsSearchBar.text?.isEmpty)! && !searchController.isActive ? .filter : .all
    }
  
    
}




