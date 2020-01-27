//
//  AlertPresenter.swift
//  EOSAccountApp
//
//  Created by Ilia Nikolaenko on 25.01.20.
//  Copyright © 2020 Ilia Nikolaenko. All rights reserved.
//

import UIKit

protocol AlertPresenter {
    
    func showAlert(title: String, message: String, buttonTitle: String, handler: ((UIAlertAction) -> Void)?)
    
    func showInputDialog(title:String?,
                         subtitle:String?,
                         actionTitle:String?,
                         cancelTitle:String?,
                         inputPlaceholder:String?,
                         inputKeyboardType:UIKeyboardType,
                         cancelHandler: ((UIAlertAction) -> Swift.Void)?,
                         actionHandler: ((_ text: String) -> Void)?)
}

extension AlertPresenter where Self: UIViewController {
    
    func showAlert(title: String, message: String, buttonTitle: String, handler: ((UIAlertAction) -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: buttonTitle, style: .cancel, handler: handler))
        present(alert, animated: true, completion: nil)
    }
    
    func showInputDialog(title:String? = nil,
                         subtitle:String? = nil,
                         actionTitle:String?,
                         cancelTitle:String? = "Cancel",
                         inputPlaceholder:String? = nil,
                         inputKeyboardType:UIKeyboardType = UIKeyboardType.default,
                         cancelHandler: ((UIAlertAction) -> Swift.Void)? = nil,
                         actionHandler: ((_ text: String) -> Void)? = nil) {
        
        let alert = UIAlertController(title: title, message: subtitle, preferredStyle: .alert)
        alert.addTextField { (textField:UITextField) in
            textField.placeholder = inputPlaceholder
            textField.keyboardType = inputKeyboardType
        }
        alert.addAction(UIAlertAction(title: actionTitle, style: .default, handler: { (action:UIAlertAction) in
            actionHandler?(alert.textFields?.first?.text ?? "")
        }))
        alert.addAction(UIAlertAction(title: cancelTitle, style: .cancel, handler: cancelHandler))
        
        self.present(alert, animated: true, completion: nil)
    }
}
