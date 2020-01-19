//
//  NotificationCurrencyTableViewCell.swift
//  coin
//
//  Created by Waleed Afifi on 13/01/2020.
//  Copyright © 2020 Waleed Afifi. All rights reserved.
//

import Foundation
import UIKit

class NotificationCurrencyTableViewCell: GeneralTableViewCell {
    
    @IBOutlet weak var currencyImage: UIImageView!
    @IBOutlet weak var currencyName: UILabel!
    @IBOutlet weak var conditionLable: UILabel!
    @IBOutlet weak var triggerPriceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func configureCell() {
        if let obj = self.object?.object as? Notification {
            self.currencyName.text = obj.sName
            
            self.currencyImage.kf.setImage(with: URL(string: obj.sIcon))
            
            switch obj.iType {
            case 0:
                conditionLable.text = K.defaultLabel.unkownText
                triggerPriceLabel.text = K.defaultLabel.currencySymbol + String(format: "%.2f", obj.dValue)
                triggerPriceLabel.textColor = K.Color.grayColor.color_
                conditionLable.textColor = K.Color.grayColor.color_
            case 1:
                conditionLable.text = K.defaultLabel.lessThanText
                triggerPriceLabel.text = K.defaultLabel.currencySymbol + String(format: "%.2f", obj.dValue)
                triggerPriceLabel.textColor = K.Color.redColor.color_
                conditionLable.textColor = K.Color.redColor.color_
            case 2:
                conditionLable.text = K.defaultLabel.equalText
                triggerPriceLabel.text = K.defaultLabel.currencySymbol + String(format: "%.2f", obj.dValue)
                triggerPriceLabel.textColor = K.Color.blackColor.color_
                conditionLable.textColor = K.Color.blackColor.color_
            case 3:
                conditionLable.text = K.defaultLabel.moreThan
                triggerPriceLabel.text = K.defaultLabel.currencySymbol + String(format: "%.2f", obj.dValue)
                triggerPriceLabel.textColor = K.Color.greenColor.color_
                conditionLable.textColor = K.Color.greenColor.color_
            default:
                conditionLable.text = ""
            }
        }
    }
    
    @IBAction func deletePressed(_ sender: Any) {
        if let obj = self.object?.object as? Notification {
            let request = BaseRequest()
            let urlExt = K.apiCall.Triggers
            request.url = "\(urlExt)?id=\(obj.pkIID)"
            request.method = .delete
            
            parentVC?.showAlertPopUp(title: K.Alert.warningAlertTitle, message: K.Alert.warningAlertMessage, buttonAction1: {
                RequestBuilder.requestWithSuccessFullResponse(request: request) { (json) in
                    if json[K.apiParameter.status][K.apiParameter.success].boolValue == true {
                        let parent = self.parentViewController as? currencyNotificationViewController
                        parent?.tableView?.beginUpdates()
                        parent?.perform(#selector(parent?.loadTable), with: nil, afterDelay: 1.0)
                        parent?.tableView?.endUpdates()
                    }
                }
            }, buttonAction2: {
                
            })
        }
    }
}
