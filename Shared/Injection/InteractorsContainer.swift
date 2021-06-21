//
//  InteractorsContainer.swift
//  BaseProject-Redux (iOS)
//
//  Created by 조요한 on 2021/06/11.
//

extension DIContainer {
    struct Interactors {
        let githubInteractor: GitHubInteractor

        init(githubInteractor: GitHubInteractor) {
            self.githubInteractor = githubInteractor
        }

        static var stub: Self {
            .init(githubInteractor: StubGitHubInteractor())
        }
    }
}

