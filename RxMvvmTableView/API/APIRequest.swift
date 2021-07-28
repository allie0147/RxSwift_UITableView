//
//  APIRequest.swift
//  RxMvvmTableView
//
//  Created by 김도희 on 2021/07/18.
//

import Foundation
public enum RequestType: String {
    case GET, POST
}

enum APIRequest {
    case fetchUsers // multiple users
    case fetchUserPosts(id: Int) // posts of a sinlge user
    case fetchPostComments(postId: Int) // comments for a sinlge post
    case fetchPost(postId: Int) // a single post
}

extension APIRequest {
    var baseURL: URL {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com") else {
            fatalError("invalid URL")
        }
        return url
    }

    var path: String {
        switch self {
        case .fetchUsers:
            return "/users"
        case let .fetchUserPosts(id):
            return "/users/\(id)/posts"
        case let .fetchPostComments(postId):
            return "/posts/\(postId)/comments"
        case let .fetchPost(postId):
            return "/posts/\(postId)"
        }
    }

    var method: RequestType {
        switch self {
        default:
            return .GET
        }
    }

    var headers: [String: String]? {
        return ["Content-type": "application/json"]
    }

    var params: [String: String]? {
        return [:]
    }

    public func request(with requestType: Self) -> URLRequest {
        guard var components = URLComponents(url: requestType.baseURL.appendingPathComponent(requestType.path),
                                             resolvingAgainstBaseURL: false) else {
            fatalError("Unable to create URL components")
        }

        if requestType.params?.isEmpty == false {
            components.queryItems = requestType.params?.map {
                URLQueryItem(name: $0.0, value: $0.1)
            }
        }

        guard let url = components.url else {
            fatalError("Could not get url")
        }

        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        // -TODO: headerㄸㅏ로 빼기
        request.addValue("application/json", forHTTPHeaderField: "Accept")

        return request
    }
}
