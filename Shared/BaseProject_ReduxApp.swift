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
    let systemEventsHandler: SystemEventsHandler
    
    init() {
        self.systemEventsHandler = environment.systemEventsHandler
        systemEventsHandler.systemEventHandler_test()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView(container: environment.container)
                .onAppEnterForground(perform: systemEventsHandler.onAppEnterForground_test)
                .onAppEnteredBackground(perform: systemEventsHandler.onAppEnteredBackground_test)
        }
    }
}


// MARK: - Responding to App Life-Cycle Events

private extension View {
    private func onNotification(
        _ notificationName: Notification.Name,
        perform action: @escaping () -> Void
    ) -> some View {
        onReceive(NotificationCenter.default.publisher(
            for: notificationName
        )) { _ in
            action()
        }
    }
    
    func onAppEnteredBackground(
        perform action: @escaping () -> Void
    ) -> some View {
        onNotification(
            UIApplication.didEnterBackgroundNotification,
            perform: action
        )
    }
    
    func onAppEnterForground(
        perform action: @escaping () -> Void
    ) -> some View {
        onNotification(
            UIApplication.willEnterForegroundNotification,
            perform: action
        )
    }
}
