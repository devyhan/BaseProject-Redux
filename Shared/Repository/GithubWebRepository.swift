//
//  GithubWebRepository.swift
//  BaseProject-Redux (iOS)
//
//  Created by 조요한 on 2021/06/18.
//

import Combine
import Foundation

protocol GithubWebRepository: WebRepository {
    func loadGitRepository() -> AnyPublisher<GithubSearchResult<GitRepository>, Error>
}

// MARK: - Implementation

struct GithubWebRepositoryImpl: GithubWebRepository {
    
    let session: URLSession
    let baseURL: String
    let bgQueue = DispatchQueue(label: "bg_parse_queue")
    
    init(session: URLSession, baseURL: String) {
        self.session = session
        self.baseURL = baseURL
    }
    
    func loadGitRepository() -> AnyPublisher<GithubSearchResult<GitRepository>, Error> {
        Log(type: .debug, API.allRepository)
        return call(endpoint: API.allRepository)
    }
}

// MARK: - Endpoints

extension GithubWebRepositoryImpl {
    enum API {
        case allRepository
    }
}

extension GithubWebRepositoryImpl.API: APICall {
    var path: String {
        switch self {
        case .allRepository:
            return "/repositories?q=swift&sort=stars&per_page=20&page=20"
        }
    }
    
    var method: String {
        switch self {
        case .allRepository:
            return "GET"
        }
    }
    
    var headers: [String: String]? {
        return ["Accept": "application/json"]
    }
    
    func body() throws -> Data? {
        return nil
    }
}
