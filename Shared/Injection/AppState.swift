//
//  AppState.swift
//  BaseProject-Redux (iOS)
//
//  Created by 조요한 on 2021/06/11.
//

import SwiftUI
import Combine

class AppState: Equatable {
    @Published var userData = UserData()
    @Published var routing = ViewRouting()
    @Published var system = System()
}

extension AppState {
    struct UserData: Equatable {
        var repos: [String: String] = [:]
        /*
         The list of countries (Loadable<[Country]>) used to be stored here.
         It was removed for performing countries' search by name inside a database,
         which made the resulting variable used locally by just one screen (CountriesList)
         Otherwise, the list of countries could have remained here, available for the entire app.
         */
        var username: String?
    }
}

extension AppState {
    struct ViewRouting: Equatable {
        var gitRepository = SomeView.Routing()
    }
}

extension AppState {
    struct System: Equatable {
        // App
        var alphavantageBaseURL: String?
        var isActive: Bool = false
        var keyboardHeight: CGFloat = 0
        var appVersion: String = ""
        var version: [String: String] = ["version": Bundle.appVersion]
        
        // RemoteConfig
        var requierdVersion: String?
        var optionalVersion: String?
        var baseURL: String?
        var APIKey: String?
    }
}

func == (lhs: AppState, rhs: AppState) -> Bool {
    return lhs.userData == rhs.userData &&
        lhs.routing == rhs.routing &&
        lhs.system == rhs.system
}

#if DEBUG
extension AppState {
    static var preview: AppState {
        let state = AppState()
        state.system.isActive = true
        return state
    }
}
#endif
