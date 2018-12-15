//
//  Machine.swift
//  AdminApp
//
//  Created by Ahmed Zaghloul on 12/9/18.
//  Copyright © 2018 Ahmed Zaghloul. All rights reserved.
//

import Foundation

public class Content :BaseModel{

    public var ipAddress : String?
	public var ipSubnetMask : String?
	public var model : Model?
	public var locationId : Int?
	public var status : Status?
	public var type : BaseModel?
	public var serialNumber : String?
	public var version : String?
	public var communicationProtocols : [CommunicationProtocols] = []
	public var targetMachines : [Content] = []
	public var location : Int?
	public var serialNum : String?

    override init(data:AnyObject){
        super.init(data: data)
        if let data = data as? NSDictionary {
            ipAddress = data.getValueForKey(key: "ipAddress", callback: "")
            ipSubnetMask = data.getValueForKey(key: "ipSubnetMask", callback: "")
            locationId = data.getValueForKey(key: "locationId", callback: 0)
            location = data.getValueForKey(key: "location", callback: 0)
            serialNumber = data.getValueForKey(key: "serialNumber", callback: "")
            version = data.getValueForKey(key: "version", callback: "")
            serialNum = data.getValueForKey(key: "serialNum", callback: "")
            
            let statusDictionary = data.getValueForKey(key: "status", callback: NSDictionary())
            status = Status(rawValue: statusDictionary.getValueForKey(key: "id", callback: 1))
            
            let typeDictionary = data.getValueForKey(key: "type", callback: NSDictionary())
            type = BaseModel(data: typeDictionary as AnyObject)

            let modelDictionary = data.getValueForKey(key: "model", callback: NSDictionary())
            model = Model(data: modelDictionary as AnyObject)
            
            let cProtocols = data.getValueForKey(key: "communicationProtocols", callback: [])
            for p in cProtocols {
                communicationProtocols.append(CommunicationProtocols(data: p as AnyObject))
            }

            let targets = data.getValueForKey(key: "targetMachines", callback: [])
            for t in targets {
                targetMachines.append(Content(data: t as AnyObject))
            }
        }
    }

}
