//
//  NewsTableViewCell.swift
//  coin
//
//  Created by Waleed Afifi on 13/01/2020.
//  Copyright © 2020 Waleed Afifi. All rights reserved.
//

import UIKit
import SwiftDate

class NewsTableViewCell: GeneralTableViewCell {
    
    @IBOutlet weak var newsImage: UIImageView!
    @IBOutlet weak var newsDescription: UILabel!
    @IBOutlet weak var newsDate: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func configureCell() {
        if let obj = self.object?.object as? News {
            
            self.newsImage.kf.setImage(with: URL(string: obj.sImage))
            
            self.newsDescription.text = obj.sTitle
            self.newsDescription.setLineSpacing(lineSpacing: 1.4, lineHeightMultiple: 1.4)
            
            self.newsDate.text = obj.dtCreatedDate.stringToDate().dateToString(customFormat: "dd/MM/yyyy")
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = UIStoryboard.mainStoryboard.instantiateViewController(withIdentifier: K.ViewControllerIdentifire.newsByIdViewController) as! NewsByIdViewController
        
        if let obj = self.object?.object as? News {
            vc.newsId = obj.pkIID
            vc.newsImage = obj.sImage
        }
        
        let parent = self.parentViewController
        parent?.present(vc, animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath){
        if K.News.currentPage != K.News.totalPage {
            if self.indexPath.row == K.News.objectCounter - 1 {
                K.News.currentPage += 1
                
                tableView.showLoading()
                
                let parent = parentViewController
                parent?.perform(#selector(NewsListViewController.loadTable), with: nil, afterDelay: 1.0)
            }
        }
    }
}
