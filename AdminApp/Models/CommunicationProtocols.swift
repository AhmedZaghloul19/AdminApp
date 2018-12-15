//
//  Machine.swift
//  AdminApp
//
//  Created by Ahmed Zaghloul on 12/9/18.
//  Copyright © 2018 Ahmed Zaghloul. All rights reserved.
//

import Foundation

public class CommunicationProtocols :BaseModel{
	public var defaultPort : Int?
    public var type : CommunicationProtocolType?
    
    override init(data:AnyObject){
        super.init(data: data)
        if let data = data as? NSDictionary {
            defaultPort = data.getValueForKey(key: "defaultPort", callback: 0)
            type = CommunicationProtocolType(rawValue: data.getValueForKey(key: "id", callback: 1))

        }
    }

}
