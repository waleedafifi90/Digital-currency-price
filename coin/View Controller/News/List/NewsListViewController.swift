//
//  NewsListViewController.swift
//  coin
//
//  Created by Waleed Afifi on 13/01/2020.
//  Copyright © 2020 Waleed Afifi. All rights reserved.
//

import UIKit

class NewsListViewController: UIViewController {
    
    @IBOutlet weak var tableView: GeneralTableView!
    
    var newsObject: [News] = []
    
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

extension NewsListViewController {
    func setupView() {
        self.tableView.register(UINib(nibName: K.CellIdentifier.newsCell, bundle: nil), forCellReuseIdentifier: K.CellIdentifier.newsCell)
        
        let refControl = UIRefreshControl()
        refControl.addTarget(self, action: #selector(self.loadTable), for: .valueChanged)
        tableView.refreshControl = refControl
    }
    
    func localization() { }
    
    func setupData() { }
    
    func fetchData() {
        self.showHUD(progressLabel: K.defaultLabel.HUDLabel)
        
        let request = BaseRequest()
        let urlExt = K.apiCall.News
        request.url = "\(urlExt)/list?i_page_count=10&i_page_number=\(K.News.currentPage)"
        request.method = .get
        
        RequestBuilder.requestWithSuccessFullResponse(request: request) { (json) in
            if let pagination = json[K.apiParameter.pagination].dictionary {
                K.News.currentPage = pagination[K.apiParameter.iCurrentPage]?.intValue ?? 1
                K.News.totalPage = pagination[K.apiParameter.iTotalPage]?.intValue ?? 1
            }
            for item in json[K.apiCall.News].arrayValue {
                
                if self.tableView.refreshControl?.isRefreshing == true {
                    self.tableView.objects = []
                    K.News.objectCounter = 0
                    K.News.currentPage = 1
                }
                
                self.tableView.refreshControl?.endRefreshing()
                
                K.News.objectCounter += 1
                
                self.tableView.objects.append(GeneralTableViewData.init(identifier: K.CellIdentifier.newsCell, object: News(pkIID: item[K.apiParameter.PKID].intValue, sTitle: item[K.apiParameter.sTitle].stringValue, sImage: item[K.apiParameter.sImage].stringValue, sDescription: item[K.apiParameter.sDescription].stringValue, bEnabled: item[K.apiParameter.bEnable].boolValue, dtCreatedDate: item[K.apiParameter.createdDate].stringValue, dtModifiedDate: item[K.apiParameter.updatedDate].stringValue), rowHeight: 121))
            }
            
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.3) {
                self.tableView.reloadData()
                self.tableView.tableFooterView?.isHidden = true
                self.dismissHUD(isAnimated: true)
            }
        }
    }
    
    @objc func loadTable() {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.3 , execute: {
            self.fetchData()
            self.tableView.tableFooterView?.isHidden = true
        })
    }
}
