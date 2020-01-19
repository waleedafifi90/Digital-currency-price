//
//  GeneralCollectionViewCell.swift
//  Test2
//
//  Created by Mahmoud Abo-Osama on 11/19/19.
//  Copyright © 2019 iMech. All rights reserved.
//

import UIKit

protocol GeneralCollectionViewCellDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath)
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
}

class GeneralCollectionViewCell: UICollectionViewCell, GeneralCollectionViewCellDelegate {
    
    var cellDelegate: GeneralCollectionViewCellDelegate!
    
    var object: GeneralCollectionViewData?
    
    var parentVC: UIViewController?
    
    var indexPath: IndexPath!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.cellDelegate = self
    }
    
    func configureCell() {
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: 1, height: 1)
    }
}
