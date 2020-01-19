//
//  UIViewControllerExtenstion.swift
//  UITableViewExample
//
//  Created by Waleed Afifi on 19/09/2019.
//  Copyright © 2019 Waleed Afifi. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    func showAlertPopUp(title: String, message: String, buttonTitle1: String = "OK", buttonTitle2: String = "Cancel", buttonTitleStyle1: UIAlertAction.Style = .default, buttonTitleStyle2: UIAlertAction.Style = .default, buttonAction1: @escaping (()->Void), buttonAction2: @escaping (()->Void)) {
        let alert = UIAlertController.init(title: title, message: message, preferredStyle: .alert)
        let button1 = UIAlertAction.init(title: buttonTitle1, style: buttonTitleStyle1) { (action) in
            print("OK Button")
            buttonAction1()
        }
        let button2 = UIAlertAction.init(title: buttonTitle2, style: buttonTitleStyle2) { (action) in
            print("Cancel Button")
            buttonAction2()
        }
        
        alert.addAction(button1 )
        alert.addAction(button2)
        self.present(alert, animated: true, completion: nil)
    }
    
    func showErrorPopUp(title: String, message: String, buttonTitle1: String = "OK", buttonTitleStyle1: UIAlertAction.Style = .default, buttonAction1: @escaping (()->Void)) {
         let alert = UIAlertController.init(title: title, message: message, preferredStyle: .alert)
         let button1 = UIAlertAction.init(title: buttonTitle1, style: buttonTitleStyle1) { (action) in
             print("OK Button")
             buttonAction1()
         }

         alert.addAction(button1)
         self.present(alert, animated: true, completion: nil)
     }
    
    func hideKeyboardWhenTappedAround() {
         let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
         tap.cancelsTouchesInView = false
         view.addGestureRecognizer(tap)
     }

     @objc func dismissKeyboard() {
         view.endEditing(true)
     }
}
