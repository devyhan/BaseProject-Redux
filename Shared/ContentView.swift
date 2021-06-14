//
//  ContentView.swift
//  Shared
//
//  Created by 조요한 on 2021/06/11.
//

import SwiftUI
import Combine

struct ContentView: View {
    
    @State private var toggle: Bool = false
    @State private var email: String?
    let container: DIContainer
    
    var body: some View {
        content()
            .onAppear(perform: load)
            .onReceive(userDataUpdate) { self.email = $0 }
    }
}

extension ContentView {
    func content() -> some View {
        ZStack {
            Text(email ?? "")
        }
    }
}

// MARK: - Side Effects

private extension ContentView {
    func load() {
        container.interactors.gitHubinteractor
            .loadEmailAddress(email)
    }
    
    var userDataUpdate: AnyPublisher<String?, Never> {
        container.appState.updates(for: \.userData.username)
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
