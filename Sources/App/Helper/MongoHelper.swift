//
//  MongoHelper.swift
//  App
//
//  Created by Hardik on 22/04/18.
//

import Foundation
import Vapor
import MongoKitten

class MongoHelper {
    
    var mongoDB:Database!
    
    static let sharedInstance = MongoHelper()
    
    init() {
        setupMongoDB()
    }
    
    private func setupMongoDB() {
        do {
            self.mongoDB = try Database("mongodb://localhost/swiftlogger")
            
        } catch {
            print("Database not connected")
        }
    }
    
    func isDBConnected() -> Bool {
        if (mongoDB != nil) {
            return self.mongoDB.server.isConnected
        } else {
            return false
        }
    }
    
   @discardableResult func insertDocument(object:Any, className:Any,collection:String) -> String? {
        
//        let docValue = cast(value: object, to: className)
//        if docValue != nil {
//            if let value = docValue! as? Encodable {
                do {
                    let document = try BSONEncoder().encode(object as! Encodable )
                    let id = try self.mongoDB[collection].insert(document)
                    return ObjectId(id)?.hexString
                } catch {
                    return nil
                }
//            }else {
//                return nil
//            }
//        } else {
//            return nil
//        }
    }
    
    func cast<T>(value: Any, to type: T) -> T? {
        if let castedValue = value as? T {
                return castedValue
        } else {
            return nil
        }
    }
}
