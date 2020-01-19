//
//  CurrencyTableViewCell.swift
//  coin
//
//  Created by Waleed Afifi on 12/01/2020.
//  Copyright © 2020 Waleed Afifi. All rights reserved.
//

import UIKit

class CurrencyTableViewCell: GeneralTableViewCell {
    
    @IBOutlet weak var counterLabel: UILabel!
    @IBOutlet weak var currencyImage: UIImageView!
    @IBOutlet weak var currencyName: UILabel!
    @IBOutlet weak var currencyPrice: UILabel!
    @IBOutlet weak var currencyRate: UILabel!
    @IBOutlet weak var arrowImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func configureCell() {
        if let obj = self.object?.object as? Currency {
            counterLabel.text = String(indexPath.row + 1)
            
            currencyImage.kf.setImage(with: URL(string: obj.sIcon))
            
            currencyName.text = obj.sName
            
            currencyPrice.text = String(format: "%.2f", obj.dValue)
            
            currencyRate.text = String(format: "%.2f", (obj.dTrading / obj.dValue) * 100) + "%"
            
            if (obj.dTrading / obj.dValue) * 100 < 0 {
                arrowImage.image = UIImage(named: K.General.arrowDownImage)
                currencyRate.textColor = UIColor.hexColor(hex: K.Color.redColor)
                
            } else {
                arrowImage.image = UIImage(named: K.General.arrowUpImage)
                currencyRate.textColor = UIColor.hexColor(hex: K.Color.greenColor)
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == K.Currency.objectCounter - 1 {
            let parent = parentViewController
            K.Currency.currentPage += 1
            
            tableView.showLoading()
            
            parent?.perform(#selector(NewsListViewController.loadTable), with: nil, afterDelay: 1.0)
        }
    }
}
