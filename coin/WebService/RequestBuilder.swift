//
//  RequestBuilder.swift
//  UITableViewExample
//
//  Created by Waleed Afifi on 20/10/2019.
//  Copyright © 2019 Waleed Afifi. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import SVProgressHUD
import MBProgressHUD

class RequestBuilder {
    static let shared = RequestBuilder()
    
    static var headers: HTTPHeaders {
        let dic: HTTPHeaders = ["X-Client-Device-UDID": "1234"]
        return dic
    }
    
    private var parentViewController: UIViewController? {
        var parentResponder: UIResponder? = AppDelegate.shared.rootNavigationViewController
        while parentResponder != nil {
            parentResponder = parentResponder!.next
            if let viewController = parentResponder as? UIViewController {
                return viewController
            }
        }
        return nil
    }
    
    class func request(request: BaseRequest, showLoader: Bool = true, success: @escaping ((_ json: JSON) -> Void), failure: @escaping ((_ error: Error) -> Void)) {
        guard let url = URL.init(string: "\(GlobalConstant.BaseURL)\(request.url)") else { return }
        if showLoader {
            self.showLoader(isShowLoader: true)
        }
        if request.files.count > 0 {
            AF.upload(multipartFormData: { (multi) in
                for item in request.files {
                    if let data = item.data {
                        multi.append(data, withName: item.name ?? "data", fileName: item.fileName, mimeType: item.type.rawValue)
                    }
                }
                for (key, value) in request.parameters {
                    if let data = (value as AnyObject).data(using: String.Encoding.utf8.rawValue) {
                        multi.append(data, withName: key)
                    }
                }
            }, to: url, method: request.method, headers: headers, interceptor: nil).uploadProgress { progress in
                self.showLoader(inProgress: progress.fractionCompleted)
            }.responseData { response in
                ResponseHandler.responseHandler(response: response, showLoader: showLoader, request: request, url: url, success: success, failure: failure)
            }
        } else {
            AF.request(url, method: request.method, parameters: request.parameters, headers: self.headers, interceptor: nil).validate().responseData { (response) in
                ResponseHandler.responseHandler(response: response, showLoader: showLoader, request: request, url: url, success: success, failure: failure)
            }
        }
    }
    
    class func requestWithSuccessFullResponse(request: BaseRequest, showLoader: Bool = true, showErrorMessage: Bool = true, success: @escaping ((_ json: JSON) -> Void) ) {
        self.request(request: request, showLoader: showLoader, success: { (json) in
            success(json)
        }) { (error) in
            if showErrorMessage {
                RequestBuilder.shared.parentViewController?.showAlertPopUp(title: "Error", message: error.localizedDescription, buttonAction1: {
                    
                }, buttonAction2: {
                    
                })
            }
        }
    }
    
    class func showLoader(isShowLoader: Bool) {
        if isShowLoader {
//            SVProgressHUD.setDefaultMaskType(.custom)
//            SVProgressHUD.setForegroundColor(UIColor.hexColor(hex: "1E92C4"))
//            SVProgressHUD.setBackgroundColor(UIColor.white)
//            SVProgressHUD.show()
        } else {
            
//            SVProgressHUD.dismiss()
        }
    }
    
    class func showLoader(inProgress: Double) {
        SVProgressHUD.setDefaultMaskType(.custom)
        SVProgressHUD.setForegroundColor(UIColor.hexColor(hex: "1E92C4"))
        SVProgressHUD.setBackgroundColor(UIColor.white)
        SVProgressHUD.showProgress(Float(inProgress))
    }
}
