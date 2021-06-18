//
//  SystemEventHandler.swift
//  BaseProject-Redux (iOS)
//
//  Created by 조요한 on 2021/06/14.
//

import SwiftUI
import Combine
import Firebase

protocol SystemEventsHandler {
    func firebaseConfigure()
    func systemEventHandler_test()
    func onAppEnterForground_test()
    func onAppEnteredBackground_test()
}

// MARK: - Implementation

struct SystemEventsHandlerImpl: SystemEventsHandler {
    let container: DIContainer
    private var cancelBag = CancelBag()
    
    init(container: DIContainer) {
        self.container = container
    }
    
    func firebaseConfigure() {
        FirebaseApp.configure()
    }
    
    func systemEventHandler_test() {
        Log(type: .debug, "test_system_log")
    }
    
    func onAppEnterForground_test() {
        Log(type: .debug, "onAppEnterForground")
        container.appState[\.system.isActive] = false
    }
    
    func onAppEnteredBackground_test() {
        Log(type: .debug, "onAppEnteredBackground")
        container.appState[\.system.isActive] = true
    }
}
