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
    func load(gitReposotory: LoadableSubject<GithubSearchResult<GitRepository>>)
}

// MARK: - Implementation

struct GitHubInteractorImpl: GitHubInteractor {
    let appState: Store<AppState>
    let webRepository: GithubWebRepository
    
    init(appState: Store<AppState>, webRepository: GithubWebRepository) {
        self.appState = appState
        self.webRepository = webRepository
    }
    
    func loadEmailAddress(_ named: String?) {
        appState[\.system.isActive] = true
        appState[\.userData.username] = "devyhan93@gmail.com"
    }
    
    func load(gitReposotory: LoadableSubject<GithubSearchResult<GitRepository>>) {
        let cancelBag = CancelBag()
        gitReposotory.wrappedValue.setIsLoading(cancelBag: cancelBag)
        
        Just<Void>
            .withErrorType(Error.self)
            .flatMap { [webRepository] _ -> AnyPublisher<GithubSearchResult<GitRepository>, Error> in
//                dbRepository.hasLoadedCountries()
                return webRepository.loadGitRepository()
            }
//            .flatMap { hasLoaded -> AnyPublisher<Void, Error> in
//                if hasLoaded {
//                    return Just<Void>.withErrorType(Error.self)
//                } else {
//                    return self.refreshCountriesList()
//                }
//            }
//            .flatMap { [gitReposotory] in
                
//                dbRepository.countries(search: search, locale: locale)
//            }
            .sinkToLoadable {
                
                let _ = gitReposotory.wrappedValue.map {
                    $0.items[0].name
                    Log(type: .debug, $0.items[0].name)
                }
                gitReposotory.wrappedValue = $0
            }
            .store(in: cancelBag)
    }
}

struct StubGitHubInteractor: GitHubInteractor {
    func loadEmailAddress(_ binding: String?) {
    }
    func load(gitReposotory: LoadableSubject<GithubSearchResult<GitRepository>>) {
    }
}

extension Just where Output == Void {
    static func withErrorType<E>(_ errorType: E.Type) -> AnyPublisher<Void, E> {
        return withErrorType((), E.self)
    }
}

extension Just {
    static func withErrorType<E>(_ value: Output, _ errorType: E.Type
    ) -> AnyPublisher<Output, E> {
        return Just(value)
            .setFailureType(to: E.self)
            .eraseToAnyPublisher()
    }
}

extension Publisher {
    func sinkToLoadable(_ completion: @escaping (Loadable<Output>) -> Void) -> AnyCancellable {
        return sink(receiveCompletion: { subscriptionCompletion in
            if let error = subscriptionCompletion.error {
                completion(.failed(error))
            }
        }, receiveValue: { value in
            completion(.loaded(value))
        })
    }
}

extension Subscribers.Completion {
    var error: Failure? {
        switch self {
        case let .failure(error): return error
        default: return nil
        }
    }
}
