//
//  Web.swift
//  Ventuor
//
//  Created by H Sam Dean on 12/24/23.
//

import UIKit
import Foundation

class Web {
    
    fileprivate static var totalRequests = 0
    fileprivate static var maxConcurrentRequests = 0
    fileprivate static var activeRequests = 0;
    
    fileprivate class func startRequest() {
        DispatchQueue.main.async {
            Web.activeRequests += 1
            Web.totalRequests += 1
            Web.maxConcurrentRequests = max(Web.maxConcurrentRequests, Web.activeRequests)

            Web.updateNetworkStatus()
        }
    }
    
    fileprivate class func finishRequest() {
        DispatchQueue.main.async {
            Web.activeRequests -= 1
            Web.updateNetworkStatus()
        }
    }
    
    fileprivate class func updateNetworkStatus() {
        UIApplication.shared.isNetworkActivityIndicatorVisible = Web.activeRequests > 0
        if (Web.activeRequests < 0) {
            fatalError("network status out of sync")
        }
    }
    
    let VERB_GET = "GET"
    let VERB_POST  = "POST"
    
    var baseURL: URL
    var authToken: String = ""
    
    init(baseURL: String) {
        self.baseURL = URL(string: baseURL)!
    }
    
    func buildUrl(_ path: String) -> URL {
        return URL(string: path, relativeTo: self.baseURL)!
    }
    
    func req(_ path: String, verb: String, data: Data?, cb: @escaping (_ data: Data?, _ error: NSError?) -> Void) {
        let url = self.buildUrl(path)
        let request = NSMutableURLRequest(url: url)
        let session = URLSession.shared
        request.httpMethod = verb
        request.timeoutInterval = 15
        request.addValue("", forHTTPHeaderField: "If-Modified-Since")
        request.cachePolicy = URLRequest.CachePolicy.reloadIgnoringLocalCacheData

        if self.authToken != "" {
            request.addValue(self.authToken, forHTTPHeaderField: "X-Auth-Token")
        }

        let xsrf = UUID().uuidString;
        
        var cookieProperties = [HTTPCookiePropertyKey: Any]()
        
        cookieProperties[HTTPCookiePropertyKey.name] = "XSRF-TOKEN"
        cookieProperties[HTTPCookiePropertyKey.value] = xsrf
        cookieProperties[HTTPCookiePropertyKey.domain] = url.host
        cookieProperties[HTTPCookiePropertyKey.path] = "/"
        
        let cookie = HTTPCookie(properties: cookieProperties )
        HTTPCookieStorage.shared.setCookie(cookie!)

        request.addValue(xsrf, forHTTPHeaderField: "X-XSRF-TOKEN")
        
        if (data != nil) {
            request.addValue("application/json", forHTTPHeaderField: "Accept")
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = data;
        }
        
        Web.startRequest()
        let task = session.dataTask(with: request as URLRequest, completionHandler: {data, response, error -> Void in
            Web.finishRequest()
            
            let err = error
            if (error == nil) {
                let statusCode = (response as! HTTPURLResponse).statusCode
                if statusCode != 200 {
                    print("")
                    print("Network error: \(statusCode) for path \(path)")
                    
                    if let text = NSString(data: data!, encoding: String.Encoding.utf8.rawValue) as String?
                    {
                        print(self.extractErrorMessage(text))
                    }
                    print("")

                    // err = Utils.createNetworkError(statusCode)
                }
                else if (data == nil) {
                    // err = Utils.createVentuorError("Unexpected empty response from server for path: \(path)")
                }
            }
            DispatchQueue.main.async(execute: {
                cb(data, err as NSError?);
            })
        })
        task.resume()
    }

    func get(_ path: String, cb: @escaping (_ data: Data?, _ error: NSError?) -> Void) {
        req(path, verb: VERB_GET, data: nil, cb: cb);
    }
    
    func post(_ path: String, data: Data?, cb: @escaping (_ data: Data?, _ error: NSError?) -> Void) {
        req(path, verb: VERB_POST, data: data, cb: cb);
    }
    
    func extractErrorMessage(_ text: String!) -> String {
        
        let regex = try! NSRegularExpression(pattern: "<h1>(.+)</h1>",
            options: [])
        let nsString = text as NSString
        let results = regex.matches(in: text,
            options: [], range: NSMakeRange(0, nsString.length))
            
        
        if results.count > 0
        {
            return nsString.substring(with: results[0].range(at: 1))
        }
        else
        {
            return "unable to scrape html for error message :/"
        }
        
    }
    
    class func deleteCookies() {
        let cookieStorage = HTTPCookieStorage.shared
        if let cookies = cookieStorage.cookies {
            for cookie in cookies {
                HTTPCookieStorage.shared.deleteCookie(cookie)
            }
        }
        UserDefaults.standard.setValue(nil, forKeyPath: "LAST-XSRF-TOKEN-VALUE")
        UserDefaults.standard.setValue(nil, forKeyPath: "LAST-XSRF-TOKEN-DOMAIN")
    }
}
