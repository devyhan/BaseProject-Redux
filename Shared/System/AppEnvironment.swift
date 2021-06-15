//
//  AppEnvironment.swift
//  BaseProject-Redux (iOS)
//
//  Created by 조요한 on 2021/06/11.
//

import UIKit
import Combine

struct AppEnvironment {
    let container: DIContainer
    let systemEventsHandler: SystemEventsHandler
}

extension AppEnvironment {
    
    static func bootstrap() -> AppEnvironment {
        let appState = Store<AppState>(AppState())
        /*
         To see the deep linking in action:
         
         1. Launch the app in iOS 13.4 simulator (or newer)
         2. Subscribe on Push Notifications with "Allow Push" button
         3. Minimize the app
         4. Drag & drop "push_with_deeplink.apns" into the Simulator window
         5. Tap on the push notification
         
         Alternatively, just copy the code below before the "return" and launch:
         
            DispatchQueue.main.async {
                deepLinksHandler.open(deepLink: .showCountryFlag(alpha3Code: "AFG"))
            }
        */
        let interactors = configuredInteractors(appState: appState)
        let diContainer = DIContainer(appState: appState, interactors: interactors)
        let systemEventsHandler = SystemEventsHandlerImpl(container: diContainer)
        return AppEnvironment(container: diContainer,
                              systemEventsHandler: systemEventsHandler)
    }
    
    private static func configuredInteractors(appState: Store<AppState>) -> DIContainer.Interactors {
        
        let githubInteractor = GitHubInteractorImpl(appState: appState)
        
        return .init(gitHubinteractor: githubInteractor)
    }
}
