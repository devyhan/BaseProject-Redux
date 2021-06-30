//
//  BaseProject_ReduxApp.swift
//  Shared
//
//  Created by 조요한 on 2021/06/11.
//

import SwiftUI
import Firebase

@main
struct BaseProject_ReduxApp: App {
    let environment = AppEnvironment.bootstrap() 
    let systemEventsHandler: SystemEventsHandler
    
    init() {
        self.systemEventsHandler = environment.systemEventsHandler
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView(container: environment.container)
                .onAppear(perform: systemEventLoad)
                .onAppEnterForground(perform: systemEventsHandler.systemEventHandler_test)
                .onAppEnteredBackground(perform: systemEventsHandler.systemEventHandler_test)
                .willResignActiveNotification(perform: systemEventsHandler.onAppEnterForground_test)
                .didBecomeActiveNotification(perform: systemEventsHandler.onAppEnteredBackground_test)
        }
    }
}

private extension BaseProject_ReduxApp {
    func systemEventLoad() {
        systemEventsHandler.getRemoteConfigure()
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
    
    func willResignActiveNotification(
        perform action: @escaping () -> Void
    ) -> some View {
        onNotification(
            UIApplication.willResignActiveNotification,
            perform: action
        )
    }

    func didBecomeActiveNotification(
        perform action: @escaping () -> Void
    ) -> some View {
        onNotification(
            UIApplication.didBecomeActiveNotification,
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
