//
//  APIServiceProtocol.swift
//  RxMvvmTableView
//
//  Created by 김도희 on 2021/07/18.
//

import Foundation

protocol APIServiceProtocol {
    static var shared: APIService { get set }
    var requestObservable: RequestObservable { get set }

    func fetchUsers() -> Observable<[User]>
    func fetchUserPosts(id: Int) -> Observable<[UserPost]>
    func fetchPostComments(postId: Int) -> Observable<[UserPost]>
}
