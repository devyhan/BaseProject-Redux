//
//  ContentView.swift
//  Shared
//
//  Created by 조요한 on 2021/06/11.
//

import SwiftUI
import Combine

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
    @State private var email: String?
    @State private var keyboardHeight: Double?
    @State private var text: String = ""
    @State private var contentSearch = CountriesSearch()
    
    var body: some View {
        content
            .onAppear(perform: load)
            .onReceive(userDataUpdate) { self.email = $0 }
            .onReceive(keyboardHeightUpdate) { print($0) }
    }
    
    private var content: some View {
        Group {
            Text("keyboard height: \(keyboardHeight ?? 0)")
            Text("email: \(email ?? "")")
            TextField("TextField", text: $text)
        }
    }
}

// MARK: - Side Effects

private extension SomeView {
    func load() {
        injected.interactors.gitHubinteractor
            .loadEmailAddress(email)
    }
}

// MARK: - State Updates

private extension SomeView {
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
