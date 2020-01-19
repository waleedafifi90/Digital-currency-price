//
//  FavouriteCollectionViewCell.swift
//  coin
//
//  Created by Waleed Afifi on 12/01/2020.
//  Copyright © 2020 Waleed Afifi. All rights reserved.
//

import UIKit
import Kingfisher

class FavouriteCollectionViewCell: GeneralCollectionViewCell {

    @IBOutlet weak var currencyImage: UIImageView!
    @IBOutlet weak var currencyName: UILabel!
    @IBOutlet weak var currencyPrice: UILabel!
    @IBOutlet weak var cellBackground: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func configureCell() {
        if let obj = self.object?.object as? Favourite {
            cellBackground.image = UIImage(named: K.Favourite.favBackgroundArray[indexPath.row])
            
            currencyImage.kf.setImage(with: URL(string: obj.sIcon))
            
            currencyName.text = obj.sName
            
            currencyPrice.text = "\(K.defaultLabel.currencySymbol) \(obj.dValue.string(fractionDigits: 2))"
        }
    }
}
