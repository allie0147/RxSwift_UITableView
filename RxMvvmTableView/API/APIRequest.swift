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
    case fetchUser
}

extension APIRequest {
    var baseURL: URL {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/users") else {
            fatalError("invalid URL")
        }
        return url
    }

    var path: String {
        switch self {
        case .fetchUser:
            return "/"
        }
    }

    var method: RequestType {
        switch self {
        case .fetchUser:
            return .GET
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
        //headerㄸㅏ로 빼기
        request.addValue("application/json", forHTTPHeaderField: "Accept")

        return request
    }
}
