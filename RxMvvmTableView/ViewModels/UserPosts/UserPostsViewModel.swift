//
//  UserPostsViewModel.swift
//  RxMvvmTableView
//
//  Created by 김도희 on 2021/07/25.
//

import Foundation

/**
 # Single user's posts view model #
 - author: 김도희
 */
class UserPostsViewModel {
    // rx
    let disposeBag: DisposeBag
    let posts: BehaviorRelay<[UserPostsViewTableViewModel]>

    let username: String

    init(userId: Int, userName: String) {
        disposeBag = DisposeBag()
        posts = BehaviorRelay<[UserPostsViewTableViewModel]>(value: [])
        self.username = userName
        // API call
        fetchUserPosts(userId)
    }

    /**
     # [GET] User Posts #
     */
    private func fetchUserPosts(_ userId: Int) {
        APIService.shared.fetchUserPosts(id: userId)
            .map { $0.map { UserPostsViewTableViewModel($0) } } // - convert UserPost to UserPostsViewTableViewModel
            .debug()
            .bind(to: self.posts)
            .disposed(by: disposeBag)
    }
}
