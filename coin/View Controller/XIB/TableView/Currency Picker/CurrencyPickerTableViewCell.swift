//
//  CurrencyPickerTableViewCell.swift
//  coin
//
//  Created by Waleed Afifi on 13/01/2020.
//  Copyright © 2020 Waleed Afifi. All rights reserved.
//

import Foundation
import UIKit

class CurrencyPickerTableViewCell: GeneralTableViewCell {
    
    @IBOutlet weak var currencyImage: UIImageView!
    @IBOutlet weak var currencyName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func configureCell() {
        if let obj = self.object?.object as? Currency {
            self.currencyName.text = obj.sName
            
            self.currencyImage.kf.setImage(with: URL(string: obj.sIcon))
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let obj = self.object?.object as? Currency {
            K.NotificationConstant.newData["CurrencyName"] = obj.sName
            
            K.NotificationConstant.newData["CurrencyImage"] = obj.sIcon
            
            K.NotificationConstant.newData["sCode"] = obj.sCode
        }
        
        let parent = self.parentViewController
        parent?.navigationController?.popViewController(animated: true)
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if K.CurrencyPicker.currentPage != K.CurrencyPicker.totalPage {
            if self.indexPath.row == K.CurrencyPicker.objectCounter - 1 {
                K.CurrencyPicker.currentPage += 1
                          
                tableView.showLoading()
                
                let parent = parentViewController
                parent?.perform(#selector(CurrencyPickerViewController.loadTable), with: nil, afterDelay: 1.0)
            }
        }
    }
}
