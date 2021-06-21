//
//  Model.swift
//  BaseProject-Redux (iOS)
//
//  Created by 조요한 on 2021/06/18.
//

import Foundation

struct GithubSearchResult<T: Codable>: Codable {
    let items: [T]
}

struct GitRepository: Codable, Identifiable, Equatable {
    let id: Int
    let name: String
    let description: String?
    let stargazers_count: Int
    let forks: Int
    let owner: GitRepositoryOwner
}

struct GitRepositoryOwner: Codable, Identifiable, Equatable {
    let id: Int
    let login: String
    let avatar: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case login
        case avatar = "avatar_url"
    }
}
