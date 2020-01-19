//
//  ViewController.swift
//  coin
//
//  Created by Waleed Afifi on 12/01/2020.
//  Copyright © 2020 Waleed Afifi. All rights reserved.
//

import UIKit
import SwiftyJSON

class ViewController: UIViewController {
    
    @IBOutlet weak var collectionView: GeneralCollectionView!
    @IBOutlet weak var tableView: GeneralTableView!
    @IBOutlet weak var todayDateLabel: UILabel!
    
    let date = Date()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        localization()
        setupData()
        fetchData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super .viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
}

extension ViewController {
    
    func setupView() {
        self.collectionView.register(UINib.init(nibName: K.CellIdentifier.favouriteCell, bundle: nil), forCellWithReuseIdentifier: K.CellIdentifier.favouriteCell)
        
        self.collectionView.register(UINib.init(nibName: K.CellIdentifier.emptyCell, bundle: nil), forCellWithReuseIdentifier: K.CellIdentifier.emptyCell)
        
        self.tableView.register(UINib(nibName: K.CellIdentifier.currencyPriceCell, bundle: nil), forCellReuseIdentifier: K.CellIdentifier.currencyPriceCell)
        
        let refController = UIRefreshControl()
        refController.addTarget(self, action: #selector(loadTable), for: .valueChanged)
        self.tableView.refreshControl = refController
        
        todayDateLabel.text = date.dateToString(customFormat: "dd-MM-Y")
        
    }
    
    func localization() { }
    
    func setupData() { }
    
    func fetchData() {
        loadFavourite()
        
        loadCurrencies()
    }
}

extension ViewController {
    
    func loadFavourite() {
        let request = BaseRequest()
        let urlExt = K.apiCall.Favourites
        request.url = "\(urlExt)/list?i_page_count=4&i_page_number=1"
        request.method = .get
        var counter = 0
        RequestBuilder.requestWithSuccessFullResponse(request: request) { (json) in
            for item in json[K.apiCall.Favourites].arrayValue {
                
                self.collectionView.objects.append(GeneralCollectionViewData.init(identifier: K.CellIdentifier.favouriteCell, object: Favourite(pkIID: item[K.apiParameter.PKID].intValue, sCode: item[K.apiParameter.sCode].stringValue, sName: item[K.apiParameter.sName].stringValue, dValue: item[K.apiParameter.dValue].floatValue, dTrading: item[K.apiParameter.dTrading].floatValue, sIcon: item[K.apiParameter.sIcon].stringValue, bEnabled: item[K.apiParameter.bEnable].boolValue, dtCreatedDate: item[K.apiParameter.createdDate].stringValue, dtModifiedDate: item[K.apiParameter.updatedDate].stringValue), cellSize: CGSize.init(width: (UIScreen.main.bounds.size.width - 65) / 2, height: (self.collectionView.bounds.height - 10) / 2)))
                
                counter += 1
            }
            if counter < 4 {
                self.collectionView.objects.append(GeneralCollectionViewData(identifier: K.CellIdentifier.emptyCell, object: nil, cellSize: CGSize.init(width: (UIScreen.main.bounds.size.width - 65) / 2, height: (self.collectionView.bounds.height - 10) / 2)))
            }
            
            
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.3) {
                self.collectionView.collectionViewLayout.invalidateLayout()
                self.collectionView.reloadData()
            }
        }
    }
    
    func loadCurrencies() {
        let request = BaseRequest()
        let urlExt = K.apiCall.Currencies
        request.url = "\(urlExt)/list?i_page_count=20&i_page_number=\(K.Currency.currentPage)"
        request.method = .get
        
        self.showHUD(progressLabel: K.defaultLabel.HUDLabel)

        RequestBuilder.requestWithSuccessFullResponse(request: request) { (json) in
            for item in json[K.apiCall.Currencies].arrayValue {
                K.Currency.objectCounter += 1
                
                if self.tableView.refreshControl?.isRefreshing == true {
                    self.tableView.objects = []
                    K.Currency.objectCounter = 1
                }
                self.tableView.refreshControl?.endRefreshing()
                
                self.tableView.objects.append(GeneralTableViewData.init(identifier: K.CellIdentifier.currencyPriceCell, object: Currency(pkIID: item[K.apiParameter.PKID].intValue, sCode: item[K.apiParameter.sCode].stringValue, sName: item[K.apiParameter.sName].stringValue, sIcon: item[K.apiParameter.sIcon].stringValue, bEnabled: item[K.apiParameter.bEnable].boolValue, dtCreatedDate: item[K.apiParameter.createdDate].stringValue, dtModifiedDate: item[K.apiParameter.updatedDate].stringValue, dValue: item[K.apiParameter.dValue].doubleValue, dTrading: item[K.apiParameter.dTrading].doubleValue), rowHeight: 41))
            }
            
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.3) {
                self.tableView.reloadData()
                self.tableView.tableFooterView?.isHidden = true
                self.dismissHUD(isAnimated: true)
            }
        }
    }
    
    @objc func loadTable() {
        loadCurrencies()
    }
}
