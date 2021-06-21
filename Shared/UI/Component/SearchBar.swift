//
//  SearchBar.swift
//  BaseProject-Redux (iOS)
//
//  Created by 조요한 on 2021/06/18.
//

import SwiftUI
import Combine

struct SearchBar: View {
    @Environment(\.injected) private var injected: DIContainer
    @Binding var text: String
    @State private var isEditing = false
 
    var body: some View {
        HStack {
            TextField("Search ...", text: $text)
                .padding(7)
                .padding(.horizontal, 25)
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .padding(.horizontal, 10)
                .onTapGesture { // iOS 15 -> focusable()
                    withAnimation(.default) { self.isEditing = true }
                }
 
            if isEditing {
                Button(action: {
                    withAnimation(.default) { self.isEditing = false }
                    self.text = ""
                }) {
                    Text("Cancel")
                }
                .padding(.trailing, 10)
                .transition(.move(edge: .trailing))
                .animation(.default)
            }
        }
        .onReceive(keyboardHeightUpdate) {
            $0 == 0 ?
                (withAnimation(.default) { self.isEditing = false }) :
                (withAnimation(.default) { self.isEditing = true }) }
    }
}

// MARK: - State Updates

private extension SearchBar {
    var keyboardHeightUpdate: AnyPublisher<CGFloat, Never> {
        injected.appState.updates(for: \.system.keyboardHeight)
    }
}

