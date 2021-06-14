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
    
    var body: some Scene {
        WindowGroup {
            ContentView(container: environment.container)
        }
    }
}
