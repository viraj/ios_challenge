//
//  GitHubAPI.swift
//  iOS_Challenge
//
//  Created by Viraj Thenuwara on 3/10/21.
//

import Foundation

struct GitHubAPI {

    let token: String
    let loadFromServer: Bool
    
    typealias CompletionBlock = (_ response: Response?, _ error: Error?) -> Void

    func submit(request: GitHubRequest) throws -> Response {
        let urlRequest = try makeURLRequest(with: request)
        return try submit(urlRequest: urlRequest)
    }

    func makeURLRequest(with request: GitHubRequest) throws -> URLRequest {
        guard let url = URL(string: "https://api.github.com/graphql") else {
            fatalError("Failed to make url")
        }

        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.setValue("bearer \(token)", forHTTPHeaderField: "Authorization")
        if loadFromServer == true {
            isTimeToReload = true
            urlRequest.cachePolicy = .reloadIgnoringLocalCacheData
        } else {
            if isTimeToReload {
                urlRequest.cachePolicy = .reloadIgnoringLocalCacheData
            } else {
                urlRequest.cachePolicy = .returnCacheDataElseLoad
            }
            
        }
        let encoder = JSONEncoder()
        urlRequest.httpBody = try encoder.encode(request)

        return urlRequest
    }

    func submit(urlRequest: URLRequest) throws -> Response {
        var responseData: Response?
        let semaphore = DispatchSemaphore(value: 0)
        submit(urlRequest: urlRequest) { (response, error) in
            responseData = response
            semaphore.signal()
        }
        if semaphore.wait(timeout: DispatchTime.now() + 30) == .timedOut {
            throw GitHubError.requestTimedOut
        }
        guard let response = responseData else {
            throw GitHubError.invalidResponse
        }
        return response
    }

    func submit(urlRequest: URLRequest, completion: @escaping CompletionBlock) {
        let session = URLSession(configuration: URLSessionConfiguration.default, delegate: nil, delegateQueue: OperationQueue())
        let task = session.dataTask(with: urlRequest) { (data, response, error) in
            guard let data = data else {
                completion(nil, error)
                return
            }
            let decoder = JSONDecoder()
            guard let response = try? decoder.decode(Response.self, from: data) else {
                completion(nil, GitHubError.invalidResponse)
                
                return
            }
            completion(response, nil)
        }
        task.resume()
    }

}
