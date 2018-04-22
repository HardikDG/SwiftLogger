//
//  Apps.swift
//  App
//
//  Created by Hardik on 22/04/18.
//

import Foundation

struct App: Codable {
    let appName:String
    let bundleId:String
    let isEnable: Bool
    
    init(name:String,bundleId:String,isEnable:Bool = true) {
        self.appName = name
        self.bundleId = bundleId
        self.isEnable = isEnable
    }
}
