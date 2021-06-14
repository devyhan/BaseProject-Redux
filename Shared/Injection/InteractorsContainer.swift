//
//  InteractorsContainer.swift
//  BaseProject-Redux (iOS)
//
//  Created by 조요한 on 2021/06/11.
//

extension DIContainer {
    struct Interactors {
        let gitHubinteractor: GitHubInteractor

        init(gitHubinteractor: GitHubInteractor) {
            self.gitHubinteractor = gitHubinteractor
        }

        static var stub: Self {
            .init(gitHubinteractor: StubGitHubInteractor())
        }
    }
}

