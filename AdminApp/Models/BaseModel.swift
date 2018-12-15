//
//  Machine.swift
//  AdminApp
//
//  Created by Ahmed Zaghloul on 12/9/18.
//  Copyright © 2018 Ahmed Zaghloul. All rights reserved.
//

import Foundation
/**
 Base Model For All Models of the app.
 ````
 public var id : Int?
 public var name : String?
 ````
 
 - id: ID of the Object.
 - name: Name of the object.
 
 ## Important Notes ##
 - Most of app models depends on this class
 - Most of app models contains **id,name**
 */
public class BaseModel {
    public var id : Int?
    public var name : String?
    
    init(data:AnyObject){
        if let data = data as? NSDictionary {
            id = data.getValueForKey(key: "id", callback: 0)
            name = data.getValueForKey(key: "name", callback: "")
        }
    }
    
    init() {
        
    }
}
