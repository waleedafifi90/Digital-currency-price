//
//  NewsByIdViewController.swift
//  coin
//
//  Created by Waleed Afifi on 13/01/2020.
//  Copyright © 2020 Waleed Afifi. All rights reserved.
//

import UIKit
import Social
import WebKit

class NewsByIdViewController: UIViewController {
    
    @IBOutlet weak var newsTitle: UILabel!
    @IBOutlet weak var newDate: UILabel!
    @IBOutlet weak var newImage: UIImageView!
    @IBOutlet weak var newsDescription: WKWebView!
    
    var newsId: Int?
    var newsImage: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        localization()
        fetchData()
        setupData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        self.navigationController?.isNavigationBarHidden = true
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func shareButtonPressed(_ sender: Any) {
        if let text = self.newsTitle.text,
            let image = self.newImage,
            let myWebsite = URL(string: "http://currency.newline.ps/news/" + String(newsId ?? 1)) {
            let shareAll = [text , image , myWebsite] as [Any]
            let activityViewController = UIActivityViewController(activityItems: shareAll, applicationActivities: nil)
            activityViewController.popoverPresentationController?.sourceView = self.view
            self.present(activityViewController, animated: true, completion: nil)
        }
    }
    
    @IBAction func fbButtonPressed(_ sender: Any) {
        if SLComposeViewController.isAvailable(forServiceType: SLServiceTypeFacebook) {
            let fbShare:SLComposeViewController = SLComposeViewController(forServiceType: SLServiceTypeFacebook)
            
            fbShare.add(self.newsImage?.image_)
            
            fbShare.add(URL(string: "http://currency.newline.ps/news/" + String(newsId ?? 1)))
            
            fbShare.setInitialText(self.newsTitle.text)
            
            self.present(fbShare, animated: true, completion: nil)
            
        } else {
            let alert = UIAlertController(title: K.Alert.warningAlertTitle, message: K.Alert.shareAlertMessage, preferredStyle: UIAlertController.Style.alert)
            
            alert.addAction(UIAlertAction(title: K.Alert.cancelButtonTitle, style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        
    }
    
    @IBAction func twitterButtonPressed(_ sender: Any) {
        if SLComposeViewController.isAvailable(forServiceType: SLServiceTypeTwitter) {
            let tweetShare:SLComposeViewController = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
            
            tweetShare.add(self.newsImage?.image_)
            
            tweetShare.add(URL(string: "http://currency.newline.ps/news/" + String(newsId ?? 1)))
            
            tweetShare.setInitialText(self.newsTitle.text)
            
            self.present(tweetShare, animated: true, completion: nil)
            
        } else {
            
            let alert = UIAlertController(title: K.Alert.warningAlertTitle, message: K.Alert.shareAlertMessage, preferredStyle: UIAlertController.Style.alert)
            
            alert.addAction(UIAlertAction(title: K.Alert.cancelButtonTitle, style: UIAlertAction.Style.default, handler: nil))
            
            self.present(alert, animated: true, completion: nil)
        }
        
    }
}

extension NewsByIdViewController {
    func setupView() { }
    
    func localization() { }
    
    func setupData() {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1.5, execute: {
            self.dismissHUD(isAnimated: true)
        })
    }
    
    func fetchData() {
        let request = BaseRequest()
        let urlExt = K.apiCall.News
        if let id = newsId {
            request.url = "\(urlExt)?id=\(id)"
        }
        request.method = .get
        
        RequestBuilder.requestWithSuccessFullResponse(request: request) { (json) in
            for item in json[K.apiCall.News].arrayValue {
                DispatchQueue.main.async {
                    self.showHUD(progressLabel: K.defaultLabel.HUDLabel)

                    self.newDate.text = item[K.apiParameter.createdDate].stringValue.stringToDate().dateToString(customFormat: "dd MMMM Y", local: "ar")
                    
                    self.newsTitle.text = item[K.apiParameter.sTitle].stringValue
                    self.newsTitle.setLineSpacing(lineSpacing: 1.7, lineHeightMultiple: 1.7)
                                        
                    self.newImage.kf.setImage(with: URL(string: item[K.apiParameter.sImage].stringValue))
                    
                    self.newsDescription.loadHTMLString(K.News.MetaHeader + item[K.apiParameter.sDescription].stringValue, baseURL: Bundle.main.bundleURL)
                    
                }
            }
        }
    }
}
