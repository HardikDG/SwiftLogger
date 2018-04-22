//
//  Devices.swift
//  App
//
//  Created by Hardik on 21/04/18.
//

import Foundation

class Device: Codable {
    
    let appName:    String
    let bundleId:   String
    let appBuild:   Int
    let firstAppBuild: Int
    let username:   String
    let uuid:       String
    let appVersion: String
    let lastStart:  Double
    let osVersion:  String
    let os:         String
    let deviceName :String
    let firstStart: Double
    let firstAppVersion: String
    let starts:     Int
    let hostName:   String
    let deviceModel:String
    
    init(information:[String:Any]) {
        self.appName =     information["appName"] as? String ?? ""
        self.bundleId =    information["bundleId"] as? String ?? ""
        self.appBuild =    information["appBuild"] as? Int ?? 0
        self.firstAppBuild = information["firstAppBuild"] as? Int ?? 0
        self.username =    information["username"] as? String ?? ""
        self.uuid =        information["uuid"] as? String ?? ""
        self.appVersion =  information["appVersion"] as? String ?? ""
        self.lastStart =   information["lastStart"] as? Double ?? 0.0
        self.osVersion =   information["osVersion"] as? String ?? ""
        self.os =          information["os"] as? String ?? ""
        self.deviceName =  information["deviceName"] as? String ?? ""
        self.firstStart =   information["firstStart"] as? Double ?? 0.0
        self.firstAppVersion =  information["firstAppVersion"] as? String ?? ""
        self.starts =      information["starts"] as? Int ?? 0
        self.hostName =    information["hostName"] as? String ?? ""
        self.deviceModel = information["deviceModel"] as? String ?? ""
    }
}
