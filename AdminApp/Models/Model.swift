//
//  Machine.swift
//  AdminApp
//
//  Created by Ahmed Zaghloul on 12/9/18.
//  Copyright © 2018 Ahmed Zaghloul. All rights reserved.
//

import Foundation

public class Model :BaseModel{
	public var creationDate : String?
	public var expiryDate : String?
    
    override init(data:AnyObject){
        super.init(data: data)
        if let data = data as? NSDictionary {
            creationDate = data.getValueForKey(key: "creationDate", callback: "")
            expiryDate = data.getValueForKey(key: "expiryDate", callback: "")
        }
    }
}
