//
//  AppEnvironment.swift
//  BaseProject-Redux (iOS)
//
//  Created by 조요한 on 2021/06/11.
//

import UIKit
import Combine
import Firebase

struct AppEnvironment {
    let container: DIContainer
    let systemEventsHandler: SystemEventsHandler
}

extension AppEnvironment {
    
    #if DEBUG
    static let isDebug = true
    #else
    static let isDebug = false
    #endif
    
    #if DEBUG
    static let flavor = "Debug"
    #else
    static let flavor = "Release"
    #endif
    
    static func bootstrap() -> AppEnvironment {
        let appState = Store<AppState>(AppState())
        
        let session = configuredURLSession()
        let webRepositories = configuredWebRepositories(session: session)
        let interactors = configuredInteractors(appState: appState,
                                                webRepository: webRepositories)
        let diContainer = DIContainer(appState: appState, interactors: interactors)
        let systemEventsHandler = SystemEventsHandlerImpl(container: diContainer)
        return AppEnvironment(container: diContainer,
                              systemEventsHandler: systemEventsHandler)
    }
    
    private static func configuredURLSession() -> URLSession {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 60
        configuration.timeoutIntervalForResource = 120
        configuration.waitsForConnectivity = true
        configuration.httpMaximumConnectionsPerHost = 5
        configuration.requestCachePolicy = .returnCacheDataElseLoad
        configuration.urlCache = .shared
        return URLSession(configuration: configuration)
    }
    
    private static func configuredWebRepositories(session: URLSession) -> DIContainer.WebRepositories {
        let gitWebRepository = GithubWebRepositoryImpl(
            session: session,
            baseURL: "https://api.github.com/search")
        
        return .init(gitRepository: gitWebRepository)
    }
    
    private static func configuredInteractors(appState: Store<AppState>,
                                              webRepository: DIContainer.WebRepositories
    ) -> DIContainer.Interactors {
        
        let githubInteractor = GitHubInteractorImpl(appState: appState, webRepository: webRepository.gitRepository)
        
        return .init(githubInteractor: githubInteractor)
    }
}

extension DIContainer {
    struct WebRepositories {
        let gitRepository: GithubWebRepository
    }
}
