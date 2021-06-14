//
//  GitHubInteractor.swift
//  BaseProject-Redux (iOS)
//
//  Created by 조요한 on 2021/06/11.
//

import SwiftUI
import Combine

protocol GitHubInteractor {
    func loadEmailAddress(_ named: String?)
}

// MARK: - Implementation

struct GitHubInteractorImpl: GitHubInteractor {
    let appState: Store<AppState>
    
    init(appState: Store<AppState>) {
        self.appState = appState
    }
    
    func loadEmailAddress(_ named: String?) {
        appState[\.userData.username] = "devyhan93@gmail.com"
    }
}

struct StubGitHubInteractor: GitHubInteractor {
    func loadEmailAddress(_ binding: String?) {
    }
}
