//
//  EmptyCellCollectionViewCell.swift
//  coin
//
//  Created by Waleed Afifi on 14/01/2020.
//  Copyright © 2020 Waleed Afifi. All rights reserved.
//

import UIKit

class EmptyCellCollectionViewCell: GeneralCollectionViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func configureCell() {
        
    }

    @IBAction func addFavPressed(_ sender: Any) {
        let vc = UIStoryboard.mainStoryboard.instantiateViewController(withIdentifier: K.ViewControllerIdentifire.currencyPickerViewController) as! CurrencyPickerViewController
        let parent = parentViewController
        parent?.show(vc, sender: self)
    }
}
