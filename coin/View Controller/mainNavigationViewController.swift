//
//  mainNavigationViewController.swift
//  coin
//
//  Created by Waleed Afifi on 13/01/2020.
//  Copyright © 2020 Waleed Afifi. All rights reserved.
//

import UIKit

class mainNavigationViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        localization()
        setupData()
        fetchData()
    }
}

extension mainNavigationViewController {
    func setupView() {
        AppDelegate.shared.rootNavigationViewController = self
        self.navigationController?.isNavigationBarHidden = true
    }
    
    func localization() { }
    
    func setupData() { }
    
    func fetchData() { }
}
