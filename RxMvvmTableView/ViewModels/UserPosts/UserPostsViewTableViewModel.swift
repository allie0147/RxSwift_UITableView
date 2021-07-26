//
//  UserPostsViewTableViewModel.swift
//  RxMvvmTableView
//
//  Created by 김도희 on 2021/07/25.
//

import Foundation

/**
 # UserPostsViewController TableView ViewModel #
 - author: 김도희
 */
struct UserPostsViewTableViewModel {
    var id: String
    var title: String
    var body: String

    init(_ post: UserPost) {
        self.id = "\(post.id)"
        self.title = post.title
        self.body = post.body
    }

    init(id: String, title: String, body: String) {
        self.id = id
        self.title = title
        self.body = body
    }

    init() {
        self.init(id: "", title: "", body: "")
    }
}
