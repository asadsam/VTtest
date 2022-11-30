
import Foundation
import UIKit
extension NSObject
{
    func convertModelToData<T:Codable>(_ model:T)->Data?
    {
        do
        {
            let reqData = try JSONEncoder().encode(model)
            return reqData
        }
        catch let error
        {
            print(error)
            return nil
        }
    }
    func convertDataToModel<E:Codable>(_ data:Data , type:E.Type)->E?
    {
        do
        {
            let response = try JSONDecoder().decode(type, from: data)
            return response
        }
        catch let error
        {
            print(error)
            return nil
        }
    }
    
    func isConnectedToInternet(errorMessage:String = "Not connected to internet")->Bool
       {
           let status = Reach().connectionStatus()
           
           switch status
           {
           case .unknown, .offline:
   //            displayActivityAlert(title: errorMessage)
               return false
           case .online(.wwan):
               return true
           case .online(.wiFi):
               return true
           }
           
       }
}


public extension UIViewController
{
    static func topMostViewController() -> UIViewController? {
          
           
        return UIApplication.shared.mainKeyWindow?.rootViewController?.topMostViewController()
       }
       
       func topMostViewController() -> UIViewController? {
           if let navigationController = self as? UINavigationController {
               return navigationController.topViewController?.topMostViewController()
           }
           else if let tabBarController = self as? UITabBarController {
               if let selectedViewController = tabBarController.selectedViewController {
                   return selectedViewController.topMostViewController()
               }
               return tabBarController.topMostViewController()
           }
               
           else if let presentedViewController = self.presentedViewController {
               return presentedViewController.topMostViewController()
           }
           
           else {
               return self
           }
       }
    func hideNavigationBar(flag:Bool)
       {
           self.navigationController?.setNavigationBarHidden(flag, animated: true)
       }
    func showHUD(message:String)
    {
        DispatchQueue.main.async {
            ALLoadingView.manager.resetToDefaults()
            ALLoadingView.manager.showLoadingView(ofType: .messageWithIndicator, windowMode: .fullscreen)
            ALLoadingView.manager.messageText = message
        }
        
    }
    func hideHUD()
    {
        DispatchQueue.main.async {
            ALLoadingView.manager.hideLoadingView(withDelay: 0.0)
        }
    }
    func displayCustomAlert(title:String)
    {
//        let alert = AlertViewController()
//        alert.m_message = title
//        alert.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
//        alert.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
//        self.present(alert, animated: true, completion: nil)
    }
    
    func displayActivityAlert(title: String)
    {
        DispatchQueue.main.async
            {
                let pending = UIAlertController(title: title, message: nil, preferredStyle: .alert)
                
                self.present(pending, animated: true, completion: nil)
                let deadlineTime = DispatchTime.now() + .seconds(2)
                DispatchQueue.main.asyncAfter(deadline: deadlineTime)
                {
                    pending.dismiss(animated: true, completion: nil)
                    
                }
        }
        
    }
   
     func setNavigationTitleBar(addRightBarButton: Bool = true)
        {
    //        return
            let logo = UIImage(named: "appLogo")
            let imageView = UIImageView(image:logo)
            let y:CGFloat = 8.0
//            imageView.frame = CGRect(x: (self.navigationController?.navigationBar.center.x)!-150, y: y, width: 30, height: 30)
            imageView.frame = CGRect(x: 0, y: y, width: 40, height: 40)

            let label = UILabel(frame: CGRect(x: imageView.frame.origin.x+imageView.frame.size.width+20, y: y, width: 150, height: 30))
            label.text = "Good Night"
            label.textColor = .white //UIColor(red: 156/255, green: 46/255, blue: 62/255, alpha: 1.0)
            label.font = UIFont.boldSystemFont(ofSize: 16.0)

            let titleView = UIView(frame: (self.navigationController?.navigationBar.frame)!)
            titleView.addSubview(imageView)
            titleView.addSubview(label)
            titleView.backgroundColor = .clear
            self.navigationItem.titleView = titleView
            
            if(addRightBarButton)
            {
                let searchImage = UIImage.init(named: "magnifyingglass")
                let searchButton = UIBarButtonItem(image:searchImage, style: .plain, target: self, action: #selector(searchButtonClicked(sender:)))
                self.navigationItem.rightBarButtonItem=searchButton
            }
            
        }
    
        @objc func searchButtonClicked(sender:UIBarButtonItem)
        {
            
        }
    
}
extension UIApplication {
    var mainKeyWindow: UIWindow? {
        get {
            if #available(iOS 13, *) {
                return connectedScenes
                    .flatMap { ($0 as? UIWindowScene)?.windows ?? [] }
                    .first { $0.isKeyWindow }
            } else {
                return keyWindow
            }
        }
    }
}


//extension String {
//         public enum DateFormatType {
//        
//        /// The ISO8601 formatted year "yyyy" i.e. 1997
//        case isoYear
//        
//        /// The ISO8601 formatted year and month "yyyy-MM" i.e. 1997-07
//        case isoYearMonth
//        
//        /// The ISO8601 formatted date "yyyy-MM-dd" i.e. 1997-07-16
//        case isoDate
//        
//        /// The ISO8601 formatted date and time "yyyy-MM-dd'T'HH:mmZ" i.e. 1997-07-16T19:20+01:00
//        case isoDateTime
//        
//        /// The ISO8601 formatted date, time and sec "yyyy-MM-dd'T'HH:mm:ssZ" i.e. 1997-07-16T19:20:30+01:00
//        case isoDateTimeSec
//        
//        /// The ISO8601 formatted date, time and millisec "yyyy-MM-dd'T'HH:mm:ss.SSSZ" i.e. 1997-07-16T19:20:30.45+01:00
//        case isoDateTimeMilliSec
//        
//        /// The dotNet formatted date "/Date(%d%d)/" i.e. "/Date(1268123281843)/"
//        case dotNet
//        
//        /// The RSS formatted date "EEE, d MMM yyyy HH:mm:ss ZZZ" i.e. "Fri, 09 Sep 2011 15:26:08 +0200"
//        case rss
//        
//        /// The Alternative RSS formatted date "d MMM yyyy HH:mm:ss ZZZ" i.e. "09 Sep 2011 15:26:08 +0200"
//        case altRSS
//        
//        /// The http header formatted date "EEE, dd MM yyyy HH:mm:ss ZZZ" i.e. "Tue, 15 Nov 1994 12:45:26 GMT"
//        case httpHeader
//        
//        /// A generic standard format date i.e. "EEE MMM dd HH:mm:ss Z yyyy"
//        case standard
//        
//        /// A custom date format string
//        case custom(String)
//        
//        /// The local formatted date and time "yyyy-MM-dd HH:mm:ss" i.e. 1997-07-16 19:20:00
//        case localDateTimeSec
//        
//        /// The local formatted date  "yyyy-MM-dd" i.e. 1997-07-16
//        case localDate
//        
//        /// The local formatted  time "hh:mm a" i.e. 07:20 am
//        case localTimeWithNoon
//        
//        /// The local formatted date and time "yyyyMMddHHmmss" i.e. 19970716192000
//        case localPhotoSave
//        
//        case birthDateFormatOne
//        
//        case birthDateFormatTwo
//        
//        ///
//        case messageRTetriveFormat
//        
//        ///
//        case emailTimePreview
//        
//        var stringFormat:String {
//          switch self {
//          //handle iso Time
//          case .birthDateFormatOne: return "dd/MM/YYYY"
//          case .birthDateFormatTwo: return "dd-MM-YYYY"
//          case .isoYear: return "yyyy"
//          case .isoYearMonth: return "yyyy-MM"
//          case .isoDate: return "yyyy-MM-dd"
//          case .isoDateTime: return "yyyy-MM-dd'T'HH:mmZ"
//          case .isoDateTimeSec: return "yyyy-MM-dd'T'HH:mm:ssZ"
//          case .isoDateTimeMilliSec: return "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
//          case .dotNet: return "/Date(%d%f)/"
//          case .rss: return "EEE, d MMM yyyy HH:mm:ss ZZZ"
//          case .altRSS: return "d MMM yyyy HH:mm:ss ZZZ"
//          case .httpHeader: return "EEE, dd MM yyyy HH:mm:ss ZZZ"
//          case .standard: return "EEE MMM dd HH:mm:ss Z yyyy"
//          case .custom(let customFormat): return customFormat
//            
//          //handle local Time
//          case .localDateTimeSec: return "yyyy-MM-dd HH:mm:ss"
//          case .localTimeWithNoon: return "hh:mm a"
//          case .localDate: return "yyyy-MM-dd"
//          case .localPhotoSave: return "yyyyMMddHHmmss"
//          case .messageRTetriveFormat: return "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
//          case .emailTimePreview: return "dd MMM yyyy, h:mm a"
//          }
//        }
// }
//        
// func toDate(_ format: DateFormatType = .isoDate) -> Date?{
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = format.stringFormat
//        let date = dateFormatter.date(from: self)
//        return date
//  }
// }


extension UIColor {
    convenience init(hexString: String) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt64()
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
}
