//
//  APIClient.swift
//  RxMvvmTableView
//
//  Created by 김도희 on 2021/07/18.
//

import Foundation

final class APIService: APIServiceProtocol {
    static var shared = APIService()
    lazy var requestObservable = RequestObservable()

    func fetchUsers() -> Observable<[User]> {
        requestObservable.call(req: .fetchUsers)
    }

    func fetchUserPosts(id: Int) -> Observable<[UserPost]> {
        requestObservable.call(req: .fetchUserPosts(id: id))
    }

//    func getRecipes() throws -> Observable<[PostModel]> {
//        var request = URLRequest(url:
//            URL(string: "https://jsonplaceholder.typicode.com/posts")!)
//        request.httpMethod = "GET"
//        request.addValue("application/json", forHTTPHeaderField:
//            "Content-Type")
//        return requestObservable.callAPI(request: request)
//    }

//    func sendPost(recipeModel: PostModel) -> Observable<PostModel> {
//        var request = URLRequest(url:
//            URL(string: "https://jsonplaceholder.typicode.com/posts")!)
//        request.httpMethod = "POST"
//        request.addValue("application/json", forHTTPHeaderField:
//            "Content-Type")
//        let payloadData = try? JSONSerialization.data(withJSONObject:
//            recipeModel.dictionaryValue!, options: [])
//        request.httpBody = payloadData
//        return requestObservable.callAPI(request: request)
//    }
}

fileprivate extension Encodable {
    var dictionaryValue: [String: Any?]? {
        guard let data = try? JSONEncoder().encode(self),
            let dictionary = try? JSONSerialization.jsonObject(with: data,
                                                               options: .allowFragments) as? [String: Any] else {
            return nil
        }
        return dictionary
    }
}
