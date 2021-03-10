//
//  Models.swift
//  iOS_Challenge
//
//  Created by Viraj Thenuwara on 3/10/21.
//

import Foundation

public struct GitHubRequest: Codable {
    let query: String
}

public struct Response: Codable {
    let data: QueryResult
}

public struct QueryResult: Codable {
    let user: User?
}

public struct User: Codable {
    let id: String
    let name: String
    let login: String
    let email: String
    let avatarUrl: String
    let followers: TotalCount?
    let following: TotalCount?
    let pinnedItems: Nodes?
    let starredRepositories: Nodes?
    let repositories: Nodes?
}

public struct TotalCount: Codable {
    let totalCount: Int?
}

public struct Nodes: Codable {
    let nodes: [Node]?
}

public struct Node: Codable {
    let id: String?
    let name: String?
    let description: String?
    let stargazerCount: Int?
    let owner: Owner?
    let languages: Languages?
}

public struct Owner: Codable {
    let id: String
    let login: String
    let avatarUrl: String
}

public struct Languages: Codable {
    let nodes: [Node]?
}


