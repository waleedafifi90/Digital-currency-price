//
//  UITableViewExtension.swift
//  coin
//
//  Created by Waleed Afifi on 15/01/2020.
//  Copyright © 2020 Waleed Afifi. All rights reserved.
//

import Foundation
import UIKit
import  MBProgressHUD

extension UIViewController {

    func showHUD(progressLabel:String){
        DispatchQueue.main.async{
            let progressHUD = MBProgressHUD.showAdded(to: self.view, animated: true)
            progressHUD.label.text = progressLabel
        }
    }

    func dismissHUD(isAnimated:Bool) {
        DispatchQueue.main.async{
            MBProgressHUD.hide(for: self.view, animated: isAnimated)
        }
    }
}

extension UITableView {
    func showLoading() {
        let label = UILabel.init(frame: CGRect(x: CGFloat(0), y: CGFloat(0), width: self.bounds.width, height: CGFloat(44)))
        
        label.textAlignment = NSTextAlignment.center
        label.font = UIFont(name: K.General.loadingFontName, size: 10)
        label.textColor = K.Color.loadingColor.color_
        label.text = K.defaultLabel.loadingLabel

        self.tableFooterView = label
        self.tableFooterView?.isHidden = false
    }
}
