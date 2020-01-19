//
//  Constants.swift
//  coin
//
//  Created by Waleed Afifi on 14/01/2020.
//  Copyright © 2020 Waleed Afifi. All rights reserved.
//

import Foundation
class K {
    struct General {
        static let defaultImage: String = "default image"
        
        static let arrowUpImage: String = "arrowUp"
        
        static let arrowDownImage: String = "arrowDown"
        
        static let fontName: String = "Swissra-Bold"
        
        static let loadingFontName: String = "Swissra-Light"
    }
    
    struct NotificationConstant {
        static var objectCounter: Int = 0
        
        static var currentPage: Int = 1
        
        static var totalPage: Int = 1
        
        static var pageCount: Int = 6
        
        static var newsObject: [Notification] = []
        
        static var newData: [String: Any] = [:]
        
        static let dropDownOptionArray: [String] = ["غير معروف", "اقل من", "يساوي", "اكبر من"]
        
    }
    
    struct News {
        static var objectCounter: Int = 0
        
        static var currentPage: Int = 1
        
        static var totalPage: Int = 1
        
        static var pageCount: Int = 6
        
        static let MetaHeader: String = """
<header>
    <meta name='viewport' content='width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no'>
<style>
     @font-face
       {
           font-family: 'Open Sans';
           font-weight: normal;
           src: url(Swissra_Normal.otf);
       }
    html{
        direction: rtl;
        font-family: 'Open Sans' !important;
    }
</style>
</header>

"""
    }
    
    struct Currency {
        static var objectCounter: Int = 0
        
        static var currentPage: Int = 1
        
        static var totalPage: Int = 1
        
        static var pageCount: Int = 6
    }
    
    struct CurrencyPicker {
        static var objectCounter: Int = 0
        
        static var currentPage: Int = 1
        
        static var totalPage: Int = 1
        
        static var pageCount: Int = 6
    }
    
    struct Favourite {
        static let favBackgroundArray = ["Rectangle 3", "Rectangle 1", "Rectangle 4", "Rectangle 2"]
    }
    
    struct Alert {
        static let errorAlertTitle: String = "خطأ"
        
        static let errorAlertMessage: String = "الرجاء التاكد من البيانات المدخلة"
        
        static let warningAlertTitle: String = "تنبيه!"
        
        static let warningAlertMessage: String = "هل انت متاكد من حذف العملة من التنبيهات؟"
        
        static let okButtonTitle: String = "موافق"
        
        static let cancelButtonTitle: String = "الغاء"
        
        static let shareAlertMessage: String = "يجب عليك تسجيل الدخول قبل مشاركة الموضوع!"
    }
    
    struct apiCall {
        static let Favourites: String = "favourites"
        
        static let Currencies: String = "currencies"
        
        static let Triggers: String = "triggers"
        
        static let News: String = "news"
        
        static let condition: String = "condition"
        
    }
    
    struct apiParameter {
        static let sName: String = "s_name"
        
        static let PKID: String = "pk_i_id"
        
        static let sCode: String = "s_code"
        
        static let dValue: String = "d_value"
        
        static let dTrading: String = "d_trading"
        
        static let sIcon: String = "s_icon"
        
        static let bEnable: String = "b_enabled"
        
        static let createdDate: String = "dt_created_date"
        
        static let updatedDate: String = "dt_modified_date"
        
        static let deletedDated: String = "dt_deleted_date"
        
        static let sTitle: String = "s_title"
        
        static let sDescription: String = "s_description"
        
        static let sImage: String = "s_image"
        
        // MARK: - Pagination Parameter
        static let iTotalObject: String = "i_total_objects"
        
        static let iItemOnPage: String = "i_items_on_page"
        
        static let iItemPerPage: String = "i_per_pages"
        
        static let iCurrentPage: String = "i_current_page"
        
        static let iTotalPage: String = "i_total_pages"
        
        static let pagination: String = "pagination"
        
        // MARK: - Status Parameter
        static let status: String = "status"
        
        static let success: String = "success"
        
        static let code: String = "code"
        
        static let message: String = "message"
        
        // MARK: - Add new Notification Parameter
        static let iType: String = "i_type"
        
        static let sUDID: String = "s_udid"
        
        static let sPnsToken: String = "s_pns_token"
    }
    
    struct CellIdentifier {
        static let newsCell: String = "NewsTableViewCell"
        
        static let notificationCell: String = "NotificationCurrencyTableViewCell"
        
        static let pickerCell: String = "CurrencyPickerTableViewCell"
        
        static let favouriteCell: String = "FavouriteCollectionViewCell"
        
        static let emptyCell: String = "EmptyCellCollectionViewCell"
        
        static let currencyPriceCell: String = "CurrencyTableViewCell"
    }
    
    struct ViewControllerIdentifire {
        static let mainViewController: String = "ViewController"
        
        static let currencyNotificationViewController: String = "currencyNotificationViewController"
        
        static let currencyPickerViewController: String = "CurrencyPickerViewController"
        
        static let newsListViewController: String = "NewsListViewController"
        
        static let newsByIdViewController: String = "NewsByIdViewController"
        
        static let mainNavigationViewController: String = "mainNavigationViewController"
        
        static let mainTabBarViewController: String = "mainTabBarViewController"
    }
    
    struct Color {
        static let grayColor: String = "CCCCCC"
        
        static let redColor: String = "E72222"
        
        static let greenColor: String = "38AD65"
        
        static let blackColor: String = "000000"
        
        static let loadingColor: String = "95989C"
    }
    
    struct defaultLabel {
        static let unkownText: String = "غير معروف"
        
        static let lessThanText: String = "اقل من"
        
        static let equalText: String = "يساوي"
        
        static let moreThan: String = "اكبر من"
        
        static let currencySymbol: String = "$"
        
        static let HUDLabel: String = "تحميل"
        
        static let chooseCurrency: String = "اختر عملة"
        
        static let loadingLabel: String = "جاري تحميل المزيد"
    }
}
