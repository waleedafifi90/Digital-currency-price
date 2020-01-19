//
//  GeneralTableView.swift
//  Test2
//
//  Created by Mahmoud Abo-Osama on 11/10/19.
//  Copyright © 2019 iMech. All rights reserved.
//

import UIKit
import DZNEmptyDataSet
import SwiftyJSON

class GeneralTableView: UITableView {
    
    typealias emptyClouser = (() -> Void)
    
    typealias jsonClouser = ((_ json: JSON) -> [Any])?
    
    var objects: [GeneralTableViewData] = []
    
    var generalRowHeight: CGFloat = 100
    
    var EmptyDataImage: UIImage? = UIImage()
    
    var EmptyDataTitle: String = ""
    
    var EmptyDataTitleFont: UIFont = .systemFont(ofSize: 15)
    
    var EmptyDataTitleColor: UIColor = .gray
    
    var isShowLoaderWhileRequest: Bool = false
    
    var isShowErrorMessage: Bool = false
    
    private var identifier: String = ""
    
    private var request: BaseRequest = BaseRequest()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.delegate = self
        self.dataSource = self
        self.emptyDataSetSource = self as? DZNEmptyDataSetSource
        self.emptyDataSetDelegate = self as? DZNEmptyDataSetDelegate
    }
    
    private var didFinish: emptyClouser?
    func didFinishRequest(_ didFinishParameter: emptyClouser?) -> GeneralTableView {
        self.didFinish = didFinishParameter
        return self
    }
    
}

extension GeneralTableView {
    func withIdentifier(identifier: String) -> GeneralTableView {
        self.identifier = identifier
        return self
    }
    
    func withRequest(request: BaseRequest) -> GeneralTableView {
        self.request = request
        return self
    }
    
    func buildRequest(jsonClouser: jsonClouser) -> GeneralTableView  {
        RequestBuilder.requestWithSuccessFullResponse(request: request, showLoader: isShowLoaderWhileRequest, showErrorMessage: isShowErrorMessage) { (json) in
            self.buildData(objs: jsonClouser?(json))
        }
        return self
    }
    
    func buildData(objs: [Any]?) {
        for item in objs ?? [] {
            self.objects.append(GeneralTableViewData.init(identifier: self.identifier, object: item, rowHeight: nil))
        }
        self.reloadData()
        self.didFinish?()
    }
}

extension GeneralTableView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objects.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let obj = self.objects[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: obj.identifier, for: indexPath) as! GeneralTableViewCell
        cell.object = obj
        cell.indexPath = indexPath
        cell.parentVC = self.parentViewController
        cell.configureCell()
        return cell
    }
}

extension GeneralTableView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! GeneralTableViewCell
        cell.cellDelegate.tableView(tableView, didSelectRowAt: indexPath)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let obj = self.objects[indexPath.row]
        return obj.rowHeight ?? self.generalRowHeight
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let cl = cell as! GeneralTableViewCell
        cl.cellDelegate.tableView(tableView, willDisplay: cell, forRowAt: indexPath)
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
}
