//
//  currencyNotificationViewController.swift
//  coin
//
//  Created by Waleed Afifi on 13/01/2020.
//  Copyright © 2020 Waleed Afifi. All rights reserved.
//

import UIKit
import iOSDropDown

class currencyNotificationViewController: UIViewController {
    
    @IBOutlet weak var currencyButton: UIButton!
    @IBOutlet weak var tableView: GeneralTableView!
    @IBOutlet weak var currencyImage: UIImageView!
    @IBOutlet weak var notificationValueTextField: UITextField!
    @IBOutlet weak var conditionPickerView: UIPickerView!
    
    var newData: [String: Any]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        notificationValueTextField.delegate = self
        
        setupView()
        localization()
        setupData()
        fetchData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.isNavigationBarHidden = true
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.3) {
            if K.NotificationConstant.newData["CurrencyName"] != nil {
                self.currencyButton.setTitle(K.NotificationConstant.newData["CurrencyName"] as? String, for: .normal)
                self.currencyImage.kf.setImage(with: URL(string: K.NotificationConstant.newData["CurrencyImage"] as! String))
            }
        }
    }
    
    @IBAction func chooseCurrencyPressed(_ sender: Any) { }
    
    @IBAction func addNotificationPressed(_ sender: Any) {
        if let dValue = notificationValueTextField?.text, notificationValueTextField.text != "", let sCode = K.NotificationConstant.newData["sCode"], let iType = K.NotificationConstant.newData["iType"] as? Int {
            let request = BaseRequest()
            
            let urlExt = K.apiCall.Triggers
            
            request.url = urlExt
            request.method = .post
            request.parameters = [K.apiParameter.sCode: sCode, K.apiParameter.iType: iType, K.apiParameter.dValue: dValue.arToEnDigits, K.apiParameter.sUDID: "1234", K.apiParameter.sPnsToken: "7gfhg"]
            
            RequestBuilder.requestWithSuccessFullResponse(request: request) { (json) in
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.3) {
                    if json[K.apiParameter.status][K.apiParameter.success].boolValue == true {
                        self.notificationValueTextField.text = ""
                        
                        self.currencyImage.image = UIImage(named: K.General.defaultImage)
                        
                        self.currencyButton.setTitle(K.defaultLabel.chooseCurrency, for: .normal)
                        
                        self.tableView.objects = []
                        
                        K.NotificationConstant.newData = [:]
                        
                        self.fetchData()
                    }
                }
            }
        } else {
            self.showErrorPopUp(title: K.Alert.errorAlertTitle, message: K.Alert.errorAlertMessage,buttonTitle1: K.Alert.okButtonTitle) { }
        }
    }
}

extension currencyNotificationViewController {
    func setupView() {
        self.tableView.register(UINib(nibName:  K.CellIdentifier.notificationCell, bundle: nil), forCellReuseIdentifier:  K.CellIdentifier.notificationCell)
        
        let refControl = UIRefreshControl()
        
        tableView.objects = []
        
        refControl.addTarget(self, action: #selector(loadTable), for: .valueChanged)
        tableView.refreshControl = refControl
        
        conditionPickerView.selectRow(1, inComponent: 0, animated: true)
        K.NotificationConstant.newData["iType"] = 1
        
        self.hideKeyboardWhenTappedAround()
        
    }
    
    func localization() { }
    
    func setupData() { }
    
    func fetchData() {
        
        let request = BaseRequest()
        let urlExt = K.apiCall.Triggers
        request.url = "\(urlExt)/list"
        request.method = .get
        
        self.showHUD(progressLabel: K.defaultLabel.HUDLabel)
        
        RequestBuilder.requestWithSuccessFullResponse(request: request) { (json) in
            for item in json[K.apiCall.condition].arrayValue {
                
                if self.tableView.refreshControl?.isRefreshing == true {
                    self.tableView.objects = []
                    
                    self.tableView.refreshControl?.endRefreshing()
                }
                
                self.tableView.objects.append(GeneralTableViewData.init(identifier: K.CellIdentifier.notificationCell, object: Notification(pkIID: item[K.apiParameter.PKID].intValue, sCode: item[K.apiParameter.sCode].stringValue, sName: item[K.apiParameter.sName].stringValue, sIcon: item[K.apiParameter.sIcon].stringValue, bEnabled: item[K.apiParameter.bEnable].boolValue, dtCreatedDate: item[K.apiParameter.createdDate].stringValue, dtModifiedDate: item[K.apiParameter.updatedDate].stringValue, dValue: item[K.apiParameter.dValue].doubleValue, iType: item[K.apiParameter.iType].intValue), rowHeight: 82))
            }
            
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.3) {
                self.tableView.reloadData()
                
                self.dismissHUD(isAnimated: true)
            }
        }
    }
    
    @objc func loadTable() {
        self.tableView.objects = []
        fetchData()
    }
}

extension currencyNotificationViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let allowedCharacters = CharacterSet(charactersIn:"0123456789١٢٣٤٥٦٧٨٩٠")//Here change this characters based on your requirement
        let characterSet = CharacterSet(charactersIn: string)
        return allowedCharacters.isSuperset(of: characterSet)
    }
}

extension currencyNotificationViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        pickerView.subviews.forEach({
            $0.isHidden = $0.frame.height < 1.0
        })
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        K.NotificationConstant.dropDownOptionArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        K.NotificationConstant.newData["iType"] = row
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return K.NotificationConstant.dropDownOptionArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let label = (view as? UILabel) ?? UILabel()
        
        label.textColor = .black
        label.textAlignment = .center
        label.font = UIFont(name: K.General.fontName, size: 11)
        
        label.text = K.NotificationConstant.dropDownOptionArray[row]
        
        return label
    }
    
    
}
