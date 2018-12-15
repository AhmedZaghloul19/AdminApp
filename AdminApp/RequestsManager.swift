//
//  RequestsManager.swift
//  AdminApp
//
//  Created by Ahmed Zaghloul on 12/9/18.
//  Copyright © 2018 Ahmed Zaghloul. All rights reserved.
//

import Foundation

/**
 **Manager of all API Reqesuts**.
 ````
 static let defaultManager = RequestsManager()
 private let requestTimoutInterval = 20.0
 ````
 
 - defaultManager: Default manager to confirm singleton pattern.
 - requestTimoutInterval: Maximum time taken for the request.
 
 ## Important Notes ##
 - This Class Confirms **Singleton Design Pattern**
 
 */
class RequestsManager :URLSession,URLSessionDelegate{
    public static var defaultManager = RequestsManager()
    let requestTimeoutInterval = 20.0
    
    private override init() {}
    
    /**
     Get Home Contents.
     
     ## It Returns ##
     - Parameter results: list of machines if found .
     */
    
    func getMachinesForPage(page:Int, completion: @escaping (_ failed:Bool,_ maxPages:Int?,_ results:[Content]?) -> Void)  {
        let url = URL(string: SERVICE_URL_PREFIX + "machine?page=0&size=10")
        var request = URLRequest(url: url!, cachePolicy: .useProtocolCachePolicy, timeoutInterval: requestTimeoutInterval)
        let configuration = URLSessionConfiguration.default
        let session = URLSession(configuration: configuration, delegate: self, delegateQueue:OperationQueue.main)
            
        request.setBodyConfigrationWithMethod(method: "GET")
        let task = session.dataTask(with: request) { (data, response, error) in
            if let res:HTTPURLResponse = response as? HTTPURLResponse {
                if error != nil || res.statusCode != 200 {
                    completion(true,nil,nil)
                    return
                }else{
                    do {
                        let json = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions()) as? NSDictionary
                        
                        var results:[Content] = []
                        if let data = json?["content"] as? [NSDictionary] {
                            for object in data {
                                let obj = Content(data: object as AnyObject)
                                results.append(obj)
                            }
                            
                            completion(false,json!.getValueForKey(key: "totalPages", callback: 1),results)
                            return
                        }else{
                            completion(true,nil,nil)
                            return
                        }
                        
                    }catch {
                        completion(true,nil,nil)
                        return
                    }
                }
            }else{
                print(error!.localizedDescription)
                completion(true,nil,nil)
                return
            }
        }
        task.resume()
    }
    
    func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        completionHandler(URLSession.AuthChallengeDisposition.useCredential,URLCredential(trust: challenge.protectionSpace.serverTrust!))
    }
    
}
