//
//  ContentView.swift
//  Shared
//
//  Created by 조요한 on 2021/06/11.
//

import SwiftUI
import Combine
import FirebaseCrashlytics

struct ContentView: View {
    let container: DIContainer
    
    var body: some View {
        content
            .inject(container)
    }
}

extension ContentView {
    var content: some View {
        SomeView()
    }
}

// MARK: - Preview

#if DEBUG
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(container: .preview)
    }
}
#endif

struct SomeView: View {
    @Environment(\.injected) private var injected: DIContainer
    @State private(set) var repositorys: Loadable<GithubSearchResult<GitRepository>>
    @State private var routingState: Routing = .init()
    private var routingBinding: Binding<Routing> {
        $routingState.dispatched(to: injected.appState, \.routing.gitRepository)
    }
    
    
    @State private var email: String?
    @State private var keyboardHeight: Double?
    @State private var text: String = ""
    @State private var contentSearch = CountriesSearch()
    
    init(repositorys: Loadable<GithubSearchResult<GitRepository>> = .notRequested) {
        self._repositorys = .init(initialValue: repositorys)
    }
    
    var body: some View {
        content
            .onAppear(perform: load)
            .onReceive(userDataUpdate) { self.email = $0 }
            .onReceive(keyboardHeightUpdate) { Log(type: .network, $0) }
            .onReceive(routingUpdate) { self.routingState = $0 }
    }
    
    private var content: some View {
        Group {
            SearchBar(text: $text)
            contents
            Spacer()
        }
    }
    
    private var contents: AnyView {
        switch repositorys {
        case .notRequested: return AnyView(Text("Not Requested"))
        case let .isLoading(last, _): return AnyView(Text("Loading view \(last.debugDescription)"))
        case let .loaded(repositorys): return AnyView(list(items: repositorys))
        case let .failed(error): return AnyView(Text("failed view \(error.localizedDescription)"))
        }
    }
    
    private func list(items: GithubSearchResult<GitRepository>) -> some View {
        ScrollView {
            ForEach(items.items) {
                Text("\($0.name)")
                Text("\($0.description ?? "")")
            }
        }
    }
}

// MARK: - Side Effects

private extension SomeView {
    func load() {
        injected.interactors.githubInteractor
            .loadEmailAddress(email)
        
        //        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
        injected.interactors.githubInteractor
            .load(gitReposotory: $repositorys)
        //        }
        
    }
}

// MARK: - Routing

extension SomeView {
    struct Routing: Equatable {
        var gitRepository: [GitRepository]?
    }
}

// MARK: - State Updates

private extension SomeView {
    
    var routingUpdate: AnyPublisher<Routing, Never> {
        injected.appState.updates(for: \.routing.gitRepository)
    }
    
    var userDataUpdate: AnyPublisher<String?, Never> {
        injected.appState.updates(for: \.userData.username)
            .delay(for: .seconds(1.5), scheduler: RunLoop.main)
            .eraseToAnyPublisher()
    }
    
    var keyboardHeightUpdate: AnyPublisher<CGFloat, Never> {
        injected.appState.updates(for: \.system.keyboardHeight)
    }
}

// MARK: - Search State

extension SomeView {
    struct CountriesSearch {
        var searchText: String = ""
        var keyboardHeight: CGFloat = 0
    }
}
