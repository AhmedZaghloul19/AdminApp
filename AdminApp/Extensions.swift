//
//  Extensions.swift
//  AdminApp
//
//  Created by Ahmed Zaghloul on 12/12/18.
//  Copyright © 2018 Ahmed Zaghloul. All rights reserved.
//

import Foundation

extension NSDictionary {
    func getValueForKey<T>(key:String,callback:T)  -> T{
        print(callback)
        if let value  = self[key]  {
            print(value)
            if let value = value as? T {
                return value
            }
            return callback
        }
        return callback
        
    }
}

// if 1 green if 2 orange if 3 yellow if 4 red
public enum Status:Int {
    case green = 1
    case orange = 2
    case yellow = 3
    case red = 4
}

public enum CommunicationProtocolType:Int {
    case telnet = 1
    case ssh = 2
    case speaker = 3
    case other
}

let SERVICE_URL_PREFIX = "https://45.55.43.15:9090/api/"
let ACCESS_TOKEN = "YWRtaW5AYm9vdC5jb206YWRtaW4="
extension URLRequest{
    mutating func setBodyConfigrationWithMethod(method:String){
        self.httpMethod = method
        self.addValue("Basic \(ACCESS_TOKEN)", forHTTPHeaderField: "Authorization")
        debugPrint(ACCESS_TOKEN)
    }
}
