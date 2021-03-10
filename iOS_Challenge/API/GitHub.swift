//
//  GitHub.swift
//  iOS_Challenge
//
//  Created by Viraj Thenuwara on 3/10/21.
//

import Foundation

public enum GitHubError: Error {
    case requestTimedOut
    case invalidResponse
    case userNotFound(name: String)
}


public struct GitHub {
    let gitHubAPI: GitHubAPI
    
    public init(token: String, fromServer: Bool = false) {
        gitHubAPI = GitHubAPI(token: token, loadFromServer: fromServer)
    }

    public func userInfo(user: String) throws -> User? {
        let query = """
            query {
              user(login: "\(user)") {
                  id
                  name
                  login
                  email
                  avatarUrl(size: 400)
                  followers {
                    totalCount
                  }
                  following {
                    totalCount
                  }
                  pinnedItems(first: 3) {
                    nodes {
                      ... on Repository {
                        id
                        name
                        description
                        stargazerCount
                        owner {
                          id
                          avatarUrl(size: 25)
                          login
                        }
                      languages(first: 1) {
                        nodes {
                            name
                        }
                      }
                      }
                    }
                  }
                  starredRepositories(first: 10, orderBy: {field: STARRED_AT, direction: DESC}) {
                    nodes {
                      id
                      name
                      description
                      stargazerCount
                      owner {
                          id
                          avatarUrl(size: 25)
                          login
                      }
                      languages(first: 1) {
                        nodes {
                            name
                        }
                      }
                    }
                  }
                  repositories(first: 10) {
                    nodes {
                      id
                      name
                      description
                      stargazerCount
                      owner {
                          id
                          avatarUrl(size: 25)
                          login
                      }
                      languages(first: 1) {
                        nodes {
                            name
                        }
                      }
                    }
                  }
                }
            }
            """

        let response = try gitHubAPI.submit(request: GitHubRequest(query: query))
        guard let responseUser = response.data.user else {
            throw GitHubError.userNotFound(name: user)
        }
        return responseUser
    }

    

}
