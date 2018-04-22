//
//  Logs.swift
//  App
//
//  Created by Hardik on 21/04/18.
//

import Foundation

struct Log: Codable {
    let thread, fileName: String
    let level: Int
    let message, logFunction: String
    let timestamp: Double
    let line: Int
    let deviceID: String
    
    init(information:[String:Any],deviceID:String) {
        self.thread = information["thread"] as? String ?? ""
        self.fileName = information["fileName"] as? String ?? ""
        self.level = information["level"] as? Int ?? 1
        self.message = information["message"] as? String ?? ""
        self.logFunction = information["logFunction"] as? String ?? ""
        self.timestamp = information["timestamp"] as? Double ?? NSDate().timeIntervalSince1970
        self.line = information["line"] as? Int ?? 1
        self.deviceID = deviceID
        
    }
}
