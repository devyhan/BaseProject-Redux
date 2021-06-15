//
//  BaseProject_ReduxApp.swift
//  Shared
//
//  Created by 조요한 on 2021/06/11.
//

import SwiftUI

@main
struct BaseProject_ReduxApp: App {
    let environment = AppEnvironment.bootstrap()
    var systemEventsHandler: SystemEventsHandler?
    
    init() {
        self.systemEventsHandler = environment.systemEventsHandler
        systemEventsHandler?.systemEventHandler_test()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView(container: environment.container)
        }
    }
}
