//
//  AppState.swift
//  BaseProject-Redux (iOS)
//
//  Created by 조요한 on 2021/06/11.
//

import SwiftUI
import Combine

class AppState: ObservableObject, Equatable {
    static func == (lhs: AppState, rhs: AppState) -> Bool {
        return lhs.userData == rhs.userData &&
            lhs.routing == rhs.routing &&
            lhs.system == rhs.system
    }
    
    @Published var userData = UserData()
    @Published var routing = ViewRouting()
    @Published var system = System()
}

extension AppState {
    struct UserData: Equatable {
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
    struct ViewRouting: Equatable { }
}

extension AppState {
    struct System: Equatable {
        var isActive: Bool = false
        var keyboardHeight: CGFloat = 0
    }
}

#if DEBUG
extension AppState {
    static var preview: AppState {
        var state = AppState()
        state.system.isActive = true
        return state
    }
}
#endif
