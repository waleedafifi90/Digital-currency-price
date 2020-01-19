//
//  CurrencyPickerViewController.swift
//  coin
//
//  Created by Waleed Afifi on 13/01/2020.
//  Copyright © 2020 Waleed Afifi. All rights reserved.
//

import UIKit

class CurrencyPickerViewController: UIViewController {
    
    @IBOutlet weak var tableView: GeneralTableView!
    
    var currencyId: Int?
    var currencyName: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        localization()
        setupData()
        fetchData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
}

extension CurrencyPickerViewController {
    func setupView() {
        self.tableView.register(UINib(nibName: K.CellIdentifier.pickerCell, bundle: nil), forCellReuseIdentifier: K.CellIdentifier.pickerCell)
        
        let refControl = UIRefreshControl()
        tableView.objects = []
        refControl.addTarget(self, action: #selector(fetchData), for: .valueChanged)
        tableView.refreshControl = refControl
    }
    
    func localization() { }
    
    func setupData() { }
    
    @objc func fetchData() {
        let request = BaseRequest()
        let urlExt = K.apiCall.Currencies
        request.url = "\(urlExt)/list?i_page_count=20&i_page_number=\(K.CurrencyPicker.currentPage)"
        request.method = .get
        
        self.showHUD(progressLabel: K.defaultLabel.HUDLabel)

        RequestBuilder.requestWithSuccessFullResponse(request: request) { (json) in
            
            K.CurrencyPicker.totalPage = json[K.apiParameter.pagination][K.apiParameter.iTotalPage].intValue
            K.CurrencyPicker.currentPage = json[K.apiParameter.pagination][K.apiParameter.iCurrentPage].intValue
            
            for item in json[K.apiCall.Currencies].arrayValue {
                K.CurrencyPicker.objectCounter += 1

                if self.tableView.refreshControl?.isRefreshing == true {
                    self.tableView.objects = []
                    K.CurrencyPicker.currentPage = 1
                }
                
                self.tableView.refreshControl?.endRefreshing()

                self.tableView.objects.append(GeneralTableViewData.init(identifier: K.CellIdentifier.pickerCell, object: Currency(pkIID: item[K.apiParameter.PKID].intValue, sCode: item[K.apiParameter.sCode].stringValue, sName: item[K.apiParameter.sName].stringValue, sIcon: item[K.apiParameter.sIcon].stringValue, bEnabled: item[K.apiParameter.bEnable].boolValue, dtCreatedDate: item[K.apiParameter.createdDate].stringValue, dtModifiedDate: item[K.apiParameter.updatedDate].stringValue, dValue: item[K.apiParameter.dValue].doubleValue, dTrading: item[K.apiParameter.dTrading].doubleValue), rowHeight: 66))
            }
            
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.3) {
                self.tableView.reloadData()
                self.tableView.tableFooterView?.isHidden = true
                self.dismissHUD(isAnimated: true)
            }
        }
    }
    
    @objc func loadTable() {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.3) {
            self.fetchData()
            self.tableView.tableFooterView?.isHidden = true
        }
    }
}
