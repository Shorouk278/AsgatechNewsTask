//
//  ViewControllerHelperExtension.swift
//  Asgatech Task
//
//  Created by Shorouk Mohamed on 7/30/21.
//  Copyright © 2021 Shorouk Mohamed. All rights reserved.
//

import KRProgressHUD

extension UIViewController{
    
    func showIndicator(){
            KRProgressHUD.show(withMessage: "Loading", completion: nil)
        }
    
    func hideIndicator(){
        KRProgressHUD.dismiss()
    }
    
    func showAlert(view: UIViewController , message: String) {
        let alert = UIAlertController(title: "Warning", message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        view.present(alert, animated: true, completion: nil)
    }

}


