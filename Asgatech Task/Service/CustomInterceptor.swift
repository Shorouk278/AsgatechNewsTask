//
//  CustomInterceptor.swift
//  Asgatech Task
//
//  Created by Shorouk Mohamed on 7/28/21.
//  Copyright © 2021 Shorouk Mohamed. All rights reserved.
//

import Foundation
import Alamofire


class CustomInterceptor: RequestInterceptor{
    
    private var retryLimit = 3
    

    func retry(_ request: Request, for session: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {
        
        if (request.response?.statusCode == 401 || request.response?.statusCode == 500) && request.retryCount < retryLimit{
            
            
            
            
            completion(.retry)
        }else{
            completion(.doNotRetry)
        }
    }
}
