//
//  NewsPresenter.swift
//  Asgatech Task
//
//  Created by Shorouk Mohamed on 7/28/21.
//  Copyright © 2021 Shorouk Mohamed. All rights reserved.
//

import Foundation

protocol NewsPresenterProtocol : class{
    func getNews()
    func configureCell(cell: NewsCellProtocol, indexPath: Int)
    func getArticles()->[Article]
    func setNewsSearchState(_ searchState: SearchState)
    func getNewsArrayCount()->Int
    func filterNews(searchText: String)
}


class NewsPresenter : NewsPresenterProtocol{
    
    var apiService : APIService?
    var articlesArray = [Article]()
    var filteredArray = [Article]()
    var presentingArray = [Article]()
    var newsTitleArray = ""
    var page = 1
    var view : NewsViewProtocol?
    
    
    
    internal init(service: APIService?, view: NewsViewProtocol){
        self.apiService = service
        self.view = view
    }
    
    
    func getNews() {
        view?.showProgress()
        
        self.view?.fetchData(isFetching: true)
        let url = API_CONSTANT.NEWS
        
        let headers = createHeaders()
        let params = createParams()
        
        apiService?.getAPI(url: url, params: params, header: headers) { [weak self] (error, response: NewsModel?) in
            guard let self = self else {return}
            if let error = error{
                self.setupView(error: error)
            }else{
                guard let response = response else {return}
                self.view?.reloadData()
                if (self.articlesArray.count) < response.totalResults{
                    self.articlesArray.append(contentsOf: response.articles)
                    self.presentingArray = self.articlesArray
                    self.view?.reloadData()
                    self.page += 1
                    self.view?.fetchData(isFetching: false)
                }
            }
            self.view?.hideProgress()
        }
    }
    
    func setupView(error: APIError) {
        switch error {
        case .connection:
            view?.setupConnectionError()
        case .somethingWrong:
            view?.setupNoData()
        case .developer:
            view?.showError(message: error.rawValue)
        }
    }
    
    func configureCell(cell: NewsCellProtocol, indexPath: Int) {
        
        cell.configureCell(title: getArticles()[indexPath].title , image: getArticles()[indexPath].urlToImage, source: articlesArray[indexPath].source
                            .name)
        
    }
    
    func filterNews(searchText: String){
        
        filteredArray = articlesArray.filter{ (Article) -> Bool in
            return Article.title.lowercased().contains(searchText.lowercased())
        }
        
    }
    
    func getArticles() -> [Article] {
        return presentingArray
    }
    
    func getNewsArrayCount() -> Int {
        return presentingArray.count
    }
    
    func setNewsSearchState(_ searchState: SearchState) {
        presentingArray.removeAll()
        switch searchState{
        case .all:
            presentingArray = articlesArray
        case .filter:
            presentingArray = filteredArray
        }
        if(presentingArray.count == 0){
            view?.reloadData()
            view?.setupNoData()
        }else{
            view?.reloadData()
        }
    }
    
    private func createHeaders() -> [String:String]{
        var headers : [String:String] = [:]
        headers[API_CONSTANT.ACCEPT_KEY] = API_CONSTANT.ACCEPT_VALUE
        return headers
    }
    
    func createParams() -> [String : Any]{
        var params : [String : Any] = [:]
        params[API_CONSTANT.Q] = "Apple"
        params[API_CONSTANT.FROM] = "2021-07-28"
        params[API_CONSTANT.SORTEDBY] = "popularity"
        params[API_CONSTANT.API_KEY] = API_CONSTANT.API_KEY_VALUE
        params[API_CONSTANT.PAGE] = page
        return params
    }
}







