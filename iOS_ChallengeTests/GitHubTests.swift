//
//  GitHubTests.swift
//  iOS_ChallengeTests
//
//  Created by Viraj Thenuwara on 3/10/21.
//

import XCTest
@testable import iOS_Challenge

let GITHUB_TOKEN = "a0f2dc3f109403171eab5b7f0c39fac1cdc3810a"
let GITHUB_USER_LOGIN = "krzysztofzablocki"

class GitHubTests: XCTestCase {
    func testToken() {
        XCTAssertEqual(GitHub(token: "testToken").gitHubAPI.token, "testToken")
    }
    
    func testUserId() {
        do {
            if let user = try GitHub(token: GITHUB_TOKEN).userInfo(user: "WenchaoD") {
                XCTAssertEqual(user.id, "MDQ6VXNlcjUxODY0NjQ=")
            } else {
                XCTFail()
            }
        } catch {
            XCTFail("invalidResponse")
        }
    }
    
    func testUserLogin() {
        do {
            if let user = try GitHub(token: GITHUB_TOKEN).userInfo(user: "WenchaoD") {
                XCTAssertEqual(user.login, "WenchaoD")
            } else {
                XCTFail()
            }
        } catch {
            XCTFail("invalidResponse")
        }
    }
    
    func testUserEmail() {
        do {
            if let user = try GitHub(token: GITHUB_TOKEN).userInfo(user: "WenchaoD") {
                XCTAssertEqual(user.email, "f33chobits@gmail.com")
            } else {
                XCTFail()
            }
        } catch {
            XCTFail("invalidResponse")
        }
    }
    
    func testUserFollowers() {
        do {
            if let user = try GitHub(token: GITHUB_TOKEN).userInfo(user: GITHUB_USER_LOGIN) {
                if let followers = user.followers {
                    XCTAssertEqual(followers.totalCount, 3273)
                } else {
                    XCTFail()
                }
                
            } else {
                XCTFail()
            }
        } catch {
            XCTFail("invalidResponse")
        }
    }

    func testUserFollowings() {
        do {
            if let user = try GitHub(token: GITHUB_TOKEN).userInfo(user: GITHUB_USER_LOGIN) {
                if let followings = user.following {
                    XCTAssertEqual(followings.totalCount, 16)
                } else {
                    XCTFail()
                }
                
            } else {
                XCTFail()
            }
        } catch {
            XCTFail("invalidResponse")
        }
    }
    
    func testShouldGetThreePinnedItems() {
        do {
            if let user = try GitHub(token: GITHUB_TOKEN).userInfo(user: GITHUB_USER_LOGIN) {
                if let pinnedItems = user.pinnedItems {
                    if let nodes = pinnedItems.nodes {
                        XCTAssertEqual(nodes.count, 3)
                    } else {
                        XCTFail()
                    }
                } else {
                    XCTFail()
                }
            } else {
                XCTFail()
            }
        } catch {
            XCTFail("invalidResponse")
        }
    }
    
    func testShouldGetTenRepositories() {
        do {
            if let user = try GitHub(token: GITHUB_TOKEN).userInfo(user: GITHUB_USER_LOGIN) {
                if let topRepositories = user.repositories {
                    if let nodes = topRepositories.nodes {
                        XCTAssertEqual(nodes.count, 10)
                    }
                } else {
                    XCTFail()
                }
            } else {
                XCTFail()
            }
        } catch {
            XCTFail("invalidResponse")
        }
    }
    
    func testShouldGetTenStarredRepositories() {
        do {
            if let user = try GitHub(token: GITHUB_TOKEN).userInfo(user: GITHUB_USER_LOGIN) {
                if let starredRepositories = user.starredRepositories {
                    if let nodes = starredRepositories.nodes {
                        XCTAssertEqual(nodes.count, 10)
                    }
                } else {
                    XCTFail()
                }
            } else {
                XCTFail()
            }
        } catch {
            XCTFail("invalidResponse")
        }
    }
    
    func testTheResponseShouldContantCorrentData() {
        guard let path = Bundle(for: type(of: self)).path(forResource: "gitResponse", ofType: "json") else {
            fatalError("Can't find search.json file")
        }
        let data = try? Data(contentsOf: URL(fileURLWithPath: path))
        let decoder = JSONDecoder()
        
        guard let response = try? decoder.decode(Response.self, from: data!) else {
            XCTFail("invalidResponse")
            return
        }
        if let user = response.data.user {
            XCTAssertEqual(user.id, "MDQ6VXNlcjE0Njg5OTM=")
            XCTAssertEqual(user.login, "krzysztofzablocki")
            XCTAssertEqual(user.name, "Krzysztof Zabłocki")
            XCTAssertEqual(user.email, "krzysztof.zablocki@pixle.pl")
            XCTAssertEqual(user.avatarUrl, "https://avatars.githubusercontent.com/u/1468993?s=400&v=4")

            
            XCTAssertEqual(user.followers?.totalCount, 3273)
            XCTAssertEqual(user.following?.totalCount, 16)
            XCTAssertEqual(user.pinnedItems?.nodes?.count, 3)
            XCTAssertEqual(user.repositories?.nodes?.count, 10)
            XCTAssertEqual(user.starredRepositories?.nodes?.count, 10)
            
            XCTAssertEqual(user.pinnedItems?.nodes?[0].owner?.login, "krzysztofzablocki")
            XCTAssertEqual(user.repositories?.nodes?[0].owner?.login, "krzysztofzablocki")
            XCTAssertEqual(user.starredRepositories?.nodes?[0].owner?.login, "johnno1962")
            
            XCTAssertEqual(user.pinnedItems?.nodes?[0].name, "Sourcery")
            XCTAssertEqual(user.repositories?.nodes?[0].name, "SFContainerViewController")
            XCTAssertEqual(user.starredRepositories?.nodes?[0].name, "HotSwiftUI")
            
            XCTAssertEqual(user.pinnedItems?.nodes?[0].stargazerCount, 5799)
            XCTAssertEqual(user.repositories?.nodes?[0].stargazerCount, 82)
            XCTAssertEqual(user.starredRepositories?.nodes?[0].stargazerCount, 38)
            
        } else {
            XCTFail("invalidResponse")
        }
    }
    
    func testTheResponseWithLessRepositoriesShouldContantCorrentData() {
        guard let path = Bundle(for: type(of: self)).path(forResource: "gitResponseViraj", ofType: "json") else {
            fatalError("Can't find search.json file")
        }
        let data = try? Data(contentsOf: URL(fileURLWithPath: path))
        let decoder = JSONDecoder()
        
        guard let response = try? decoder.decode(Response.self, from: data!) else {
            XCTFail("invalidResponse")
            return
        }
        if let user = response.data.user {
            XCTAssertEqual(user.id, "MDQ6VXNlcjI2MTE0")
            XCTAssertEqual(user.login, "viraj")
            XCTAssertEqual(user.name, "Viraj Thenuwara")
            XCTAssertEqual(user.email, "vthenuwara@gmail.com")
            XCTAssertEqual(user.avatarUrl, "https://avatars.githubusercontent.com/u/26114?s=400&v=4")

            
            XCTAssertEqual(user.followers?.totalCount, 5)
            XCTAssertEqual(user.following?.totalCount, 1)
            
            XCTAssertEqual(user.pinnedItems?.nodes?.count, 0)
            XCTAssertNotEqual(user.pinnedItems?.nodes?.count, 3)
            
            
            XCTAssertEqual(user.repositories?.nodes?.count, 9)
            XCTAssertNotEqual(user.repositories?.nodes?.count, 10)
            
            XCTAssertEqual(user.starredRepositories?.nodes?.count, 10)
            
            XCTAssertEqual(user.repositories?.nodes?[0].owner?.login, "viraj")
            XCTAssertEqual(user.starredRepositories?.nodes?[0].owner?.login, "facebookarchive")

            XCTAssertEqual(user.repositories?.nodes?[0].name, "mootools-smoothgallery")
            XCTAssertEqual(user.starredRepositories?.nodes?[0].name, "pop")

            XCTAssertEqual(user.repositories?.nodes?[0].stargazerCount, 4)
            XCTAssertEqual(user.starredRepositories?.nodes?[0].stargazerCount, 19848)
            
        } else {
            XCTFail("invalidResponse")
        }
    }
}
