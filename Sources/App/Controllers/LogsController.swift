//
//  LogsController.swift
//  App
//
//  Created by Hardik on 21/04/18.
//

import Foundation
import Vapor

class LogsController {
    
    func addLog(request:Request) throws -> ResponseRepresentable {
        
            print(MongoHelper.sharedInstance.isDBConnected())
        
            guard let payload = request.json?["payload"]?.string else {
            throw Abort(.badRequest, reason: "Sorry data format is not proper")
            }
        
            let logInformation = payload.toJSON()
        
            guard let logs = logInformation as? [String:Any]  else {
            throw Abort(.badRequest, reason: "Sorry data format is not proper")
            }
        
            guard let device = logs["device"] as? [String:Any] else {
            throw Abort(.badRequest, reason: "Sorry data format is not proper")
            }
                let deviceObj = Device(information: device)
                let insertedID = MongoHelper.sharedInstance.insertDocument(object: deviceObj, className: Device.self, collection: "devices")

                //                print(insertedID)
            guard let deviceID = insertedID else {
            throw Abort(.internalServerError, reason: "Something went wrong when submitting the log")
            }
                    var currentID:String?;
                    for entry in logs["entries"] as! [[String:Any]] {
                        let log = Log(information: entry, deviceID: deviceID)
                        currentID = MongoHelper.sharedInstance.insertDocument(object: log, className: Log.self, collection: "logs")
                    }
                    if currentID != nil {
                        print("Data submitted successfully")
                        return JSON(["message":"Data submitted successfully"])
                    }
        
        throw Abort(.badRequest, reason: "Sorry data format is not proper")
        }
}

extension String {
    func toJSON() -> Any? {
        guard let data = self.data(using: .utf8, allowLossyConversion: false) else { return nil }
        return try? JSONSerialization.jsonObject(with: data, options: .mutableContainers)
    }
}
