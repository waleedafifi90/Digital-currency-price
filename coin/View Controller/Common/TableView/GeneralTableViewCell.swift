//
//  GeneralTableViewCell.swift
//  Test2
//
//  Created by Mahmoud Abo-Osama on 11/10/19.
//  Copyright © 2019 iMech. All rights reserved.
//

import UIKit

protocol GeneralTableViewCellDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath)
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat
}

class GeneralTableViewCell: UITableViewCell, GeneralTableViewCellDelegate {
    
    var cellDelegate: GeneralTableViewCellDelegate!
    
    var object: GeneralTableViewData?
    
    var parentVC: UIViewController?
    
    var indexPath: IndexPath!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.cellDelegate = self
    }

    func configureCell() {
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath){
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
}
