//
//  APIService.swift
//  Asgatech Task
//
//  Created by Shorouk Mohamed on 7/28/21.
//  Copyright © 2021 Shorouk Mohamed. All rights reserved.
//

import UIKit
import Alamofire

enum APIError : String {
    case connection = "No Internet Connection"
    case somethingWrong = "Sorry, there was a problem. Please try again later"
    case developer = "You have requested too many results. Developer accounts are limited to a max of 100 results."
}


class APIService: NSObject {
    let domain = API_CONSTANT.DOMAIN
    
    func checkConnection() -> Bool {
        let reachabilityManager = Alamofire.NetworkReachabilityManager(host: "www.google.com")
        return (reachabilityManager?.isReachable)!
    }

    // API Get Function ===================>
    func getAPI<T: Codable>(url: String, params: [String: Any]?, header: [String: String]?,completed: @escaping (_ error: APIError?, _ response: T?) -> Void){
        
        if self.checkConnection() {
            
            var myHeader: HTTPHeaders? = nil
            
            if header != nil{
                myHeader = HTTPHeaders(header!)
            }
            
            AF.request(domain + url, method: .get,
                       parameters: params,
                       encoding: URLEncoding.default,
                       headers: myHeader,
                       interceptor: CustomInterceptor())
                .responseJSON { (response) in
                    
                    switch response.result{
                    
                    case .success(let value) :
                        
                        do{
                            guard let data = response.data else {return}
                            
                            let jsonResponse = try JSONDecoder().decode(T.self, from: data)
                            
                            completed(nil, jsonResponse)
                            
                        }catch{
                            completed(.developer, nil)
                        }
                        
                    case .failure(let error) :                        
                        completed(.somethingWrong, nil)
                    }
                    
                }
        }else{
            completed(.connection, nil)
        }
        
    }
}
