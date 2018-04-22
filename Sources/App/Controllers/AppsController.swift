//
//  AppsController.swift
//  App
//
//  Created by Hardik on 22/04/18.
//

import Foundation
import Vapor
import MongoKitten

class AppsController {
    
    
    let appCollection = MongoHelper.sharedInstance.mongoDB["apps"]
    
    func  getAppStatus(request:Request) throws -> ResponseRepresentable {
        guard let appName = request.json?["appName"]?.string, let bundleId = request.json?["bundleId"]?.string else {
            throw Abort(.badRequest,reason:"Sorry data format is not proper")
        }
        
        if let userDocument = try appCollection.findOne("bundleId" == bundleId) {
            do {
                let app = try BSONDecoder().decode(App.self, from: userDocument)
                return try app.makeResponse()
            } catch {
                
            }
        } else {
            let app = App(name: appName, bundleId: bundleId)
            let insertedId = MongoHelper.sharedInstance.insertDocument(object: app, className: App.self, collection: "apps")
            if insertedId != nil {
                return JSON(["message":"New app created","status":true])
            }
        }
        
        return JSON(["message":"App not found","status":false])
    }
    
    func  setAppStatus(request:Request) throws -> ResponseRepresentable {
        guard let isEnable = request.json?["isEnable"]?.bool, let bundleId = request.json?["bundleId"]?.string else {
            throw Abort(.badRequest,reason:"Sorry data format is not proper")
        }
        
        do {
           let updateId = try appCollection.update("bundleId" == bundleId, to: [
                "$set": ["isEnable": isEnable]])
            if updateId == 1 {
                return JSON(["message":"App status updated"])
            } else {
                return JSON(["message":"App status not updated, either app don't exist or the app is having same status"])
            }
        } catch  {
            throw Abort(.internalServerError,reason:"Something went wrong while updating the status")
        }
    }

    func getAllApps(request:Request) throws -> ResponseRepresentable {
        
        do {
            let apps:[App] = try appCollection.find().flatMap{ document in
                try BSONDecoder().decode(App.self, from: document)
            }
            return try apps.makeResponse()
        } catch  {
            throw Abort(.internalServerError,reason:"Something went wrong while getting app list")
        }
    }
    
}
