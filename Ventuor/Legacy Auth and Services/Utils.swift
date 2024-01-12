//
//  Utils.swift
//  Ventuor
//
//  Created by H Sam Dean on 1/11/24.
//

import UIKit
import Foundation
import CoreLocation

class Utils
{
    var webMetaViewPort: String = "<meta name = 'viewport' content = 'width=device-width, initial-scale=1.0'>"
    
    class func showMessage(_ message: String, withTitle: String) {
//        let vm = UIAlertView(title: withTitle, message: message, delegate: nil, cancelButtonTitle: "OK")
//        vm.show();

        let alert = UIAlertController(title: withTitle, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
        NSLog("The \"OK\" alert occured.")
        }))
    }
    
    class func showYesCancelMessage(_ message: String, withTitle: String) {
        let refreshAlert = UIAlertController(title: withTitle, message: message, preferredStyle: UIAlertController.Style.alert)
        
        refreshAlert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { (action: UIAlertAction!) in
            print("Handle Ok logic here")
        }))
        
        refreshAlert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: { (action: UIAlertAction!) in
            print("Handle Cancel Logic here")
        }))
        
    }
    
//    class func setImageFromPath(_ path: String, forView: UIImageView) {
//        let contentManager = ContentManager(baseURL: Settings.baseURL)
//        contentManager.getImage(path, cb: { (image, error) -> Void in
//            if (error == nil) {
//                forView.image = image
//            }
//        })
//    }
//    
//    class func setImageFromPath(_ path: String, forView: UITabBarItem) {
//        let contentManager = ContentManager(baseURL: Settings.baseURL)
//        contentManager.getImage(path, cb: { (image, error) -> Void in
//            if (error == nil) {
//                forView.image = image
//            }
//        })
//    }
    
//    class func setImageFromPath(_ path: String, forView: UIButton) {
//        let contentManager = ContentManager(baseURL: Settings.baseURL)
//        contentManager.getImage(path, cb: { (image, error) -> Void in
//            if (error == nil) {
//                forView.setImage(image, for: UIControl.State())
//            }
//        })
//    }
//    
//    class func setVentuorLogo(_ ventuorKey: String, liveMode: Bool, forView imageView: UIImageView)
//    {
//        let contentManager = ContentManager(baseURL: Settings.baseURL);
//        contentManager.getVentuorLogo(ventuorKey, live: liveMode) { image, error in
//            if image != nil {
//                imageView.image = image
//            } else {
//                Utils.setImageFromPath("", forView: imageView)
//            }
//        }
//    }
    
    class func removeNewLines(_ str: String) -> String {
        return str
            .replacingOccurrences(of: "\n", with: " ")
            .replacingOccurrences(of: "\r", with: " ")
            .replacingOccurrences(of: "\\n", with: " ")
    }
    
    class func getCurrentDay(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let dateString = formatter.string(from: date)
        
        let todayDate = formatter.date(from: dateString)!
        let myCalendar = Calendar(identifier: Calendar.Identifier.gregorian)
        let myComponents = (myCalendar as NSCalendar).components(.weekday, from: todayDate)
        let weekDay = myComponents.weekday
        
        return getWeekDay(weekDay!)
    }
    
    class func getCurrentDate(_ date: Date) -> String {
        
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "MM/dd/yyyy"
        
        return dateFormatter.string(from: date)
    }
    
    class func getCurrentTime(_ date: Date) -> String {
        
        let timeFormatter = DateFormatter()
        timeFormatter.timeStyle = .short
        
        return timeFormatter.string(from: date)
    }
    
    class func getWeekDay(_ num: Int) -> String {
        
        switch num {
        case 1:
            return "Sun"
        case 2:
            return "Mon"
        case 3:
            return "Tue"
        case 4:
            return "Wed"
        case 5:
            return "Thu"
        case 6:
            return "Fri"
        case 7:
            return "Sat"
        default:
            return "nil"
        }
        
    }
    
    // convert images into base64 and keep them into string
    
    class func convertImageToBase64(_ image: UIImage) -> String {
        
        let imageData = image.pngData()
        let base64String = imageData!.base64EncodedString(options: [])
        
        return base64String
        
    }
    
    class func convertBase64ToImage(_ base64String: String) -> UIImage {
        
        let decodedData = Data(base64Encoded: base64String, options: Data.Base64DecodingOptions(rawValue: 0) )
        
        let decodedimage = UIImage(data: decodedData!)
        
        return decodedimage!
        
    }
    
    
    class func removeExtraSlashLines(_ str: String) -> String {
        return str
            .replacingOccurrences(of: "\\/", with: "/")
            .replacingOccurrences(of: "\\/", with: "/")
    }
    
    class func decodeHtmlString(_ str: String) -> String {
        
        let encodedData = str.data(using: .utf8)!
        // Swift 4 Change
        let attributedOptions : [NSAttributedString.DocumentReadingOptionKey : Any ] = [
            NSAttributedString.DocumentReadingOptionKey(rawValue: NSAttributedString.DocumentAttributeKey.documentType.rawValue): NSAttributedString.DocumentType.html as AnyObject,
            NSAttributedString.DocumentReadingOptionKey(rawValue: NSAttributedString.DocumentAttributeKey.characterEncoding.rawValue): String.Encoding.utf8.rawValue as AnyObject ]
        let attributedString = try! NSAttributedString(data: encodedData, options: attributedOptions, documentAttributes: nil)
//        let attributedOptions : [String : AnyObject ] = [
//            NSAttributedString.DocumentAttributeKey.documentType.rawValue: NSAttributedString.DocumentType.html as AnyObject,
//            NSAttributedString.DocumentAttributeKey.characterEncoding.rawValue: String.Encoding.utf8.rawValue as AnyObject ]
//        let attributedString = try! NSAttributedString(data: encodedData, options: attributedOptions, documentAttributes: nil)

        return attributedString.string
        
    }
    
    class func createVentuorError(_ message: String) -> NSError
    {
        let details = [
            "ventuor-message": message
        ]
        return NSError(domain: "Ventuor", code: 0, userInfo: details)
    }
    
    class func createVentuorError(_ provided: NSError?, defaultMessage: String) -> NSError
    {
        var message = defaultMessage
        if let error = provided
        {
            message = "\(error.domain) error: \(error.debugDescription )"
        }
        
        return createVentuorError(message)
    }
    
    class func createNetworkError(_ statusCode: Int) -> NSError
    {
        return NSError(domain: "HTTPException", code: statusCode, userInfo: nil)
    }
    
//    class func showServiceCallErrorMsg(_ message: String, screenTitle: String, screenType: String) {
//        
//        let alertController = UIAlertController (title: "Something went wrong", message: message, preferredStyle: .alert)
//        
//        let okAction = UIAlertAction(title: "OK", style: .default) { (_) -> Void in
//            if( screenTitle == "Loading" && screenType == "ListScreen" ) {
//                let controller = ScreenManager.instance.getTopController()
//                controller.hideLoadingIndicator()
//                _ = controller.navigationController?.popViewController(animated: false)
//            }
//        }
//        alertController.addAction(okAction)
//        
//        ScreenManager.instance.getTopController().present(alertController, animated: true, completion: nil)
//    }
    
//    class func showSpecialErrorMsg(_ message: String, screenTitle: String) {
//        
//        let alertController = UIAlertController (title: screenTitle, message: message, preferredStyle: .alert)
//        
//        let okAction = UIAlertAction(title: "OK", style: .default) { (_) -> Void in
//        }
//        alertController.addAction(okAction)
//        
//        ScreenManager.instance.getTopController().present(alertController, animated: true, completion: nil)
//    }
    
    class func getLocaleCountryName(lastUpdatedLocation: CLLocationCoordinate2D, cb: @escaping (_ country: String?) -> Void) {
        //Fetch from settings.
        let locale = Locale.current
        let countryCode = (locale as NSLocale).object(forKey: NSLocale.Key.countryCode) as! String
        var country = (locale as NSLocale).displayName(forKey: NSLocale.Key.countryCode, value: countryCode)!
        
        if lastUpdatedLocation.latitude != 0 && lastUpdatedLocation.longitude != 0 {
            let geoCoder = CLGeocoder()
            let location = CLLocation(latitude: lastUpdatedLocation.latitude, longitude: lastUpdatedLocation.longitude)
            geoCoder.reverseGeocodeLocation(location) {
                (placemarks, error) -> Void in
                
                let placeArray = placemarks as [CLPlacemark]?
                
                // Place details
                var placeMark: CLPlacemark!
                placeMark = placeArray?[0]
                
                // Country
                if let countryName = placeMark.country as? NSString {
                    country = countryName as String
                }
                cb(country)
            }
        } else {
            cb(country)
        }
    }
}

extension UIColor
{
    class func fromHexString(_ hexString: String) -> UIColor
    {
        var hex = hexString
        if hex[hex.startIndex] == "#"
        {
            hex = String(hex[hex.index(hex.startIndex, offsetBy: 1)...])
            // Swift 4 Change
            //hex = hex.substring(from: hex.characters.index(hex.startIndex, offsetBy: 1))
        }
        if hex.count == 3 {
            let r = hex[hex.startIndex]
            let g = hex[hex.index(hex.startIndex, offsetBy: 1)]
            let b = hex[hex.index(hex.startIndex, offsetBy: 2)]
            hex = "\(r)\(r)\(g)\(g)\(b)\(b)"
        }
        
        let n = strtoul(hex, nil, 16)
        let r = (Float)((n & 0xFF0000) >> 16) / 255.0
        let g = (Float)((n & 0xFF00) >> 8) / 255.0
        let b = (Float)(n & 0xFF) / 255.0
        
        return UIColor(red: CGFloat(r), green: CGFloat(g), blue: CGFloat(b), alpha: CGFloat(1))
    }
}
