//
//  PostCommentsTableViewModel.swift
//  RxMvvmTableView
//
//  Created by 김도희 on 2021/07/27.
//

import Foundation

/**
 # PostCommentsVC TableView ViewModel #
 - author: 김도희
 */
struct PostCommentsTableViewModel {

    var name: String
    var body: String

    init(_ comments: Comment) {
        self.name = comments.name
        self.body = comments.body
    }

    init(name: String, body: String) {
        self.name = name
        self.body = body
    }

    init() {
        self.init(name: "", body: "")
    }
}
