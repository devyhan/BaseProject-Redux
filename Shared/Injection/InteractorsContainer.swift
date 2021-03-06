//
//  InteractorsContainer.swift
//  BaseProject-Redux (iOS)
//
//  Created by ์กฐ์ํ on 2021/06/11.
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

