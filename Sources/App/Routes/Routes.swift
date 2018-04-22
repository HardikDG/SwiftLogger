import Vapor

extension Droplet {
    func setupRoutes() throws {

        let v1 = grouped("api/v1")
        
        let _ = MongoHelper.sharedInstance
        
        let logController = LogsController()
        v1.post("log/send-log", handler: logController.addLog)
        
        let appController = AppsController()
        v1.post("apps/get-app-status", handler: appController.getAppStatus)
        v1.post("apps/set-app-status", handler: appController.setAppStatus)
        v1.get("apps/get-apps", handler: appController.getAllApps)
//        try resource("posts", PostController.self)
    }
}
