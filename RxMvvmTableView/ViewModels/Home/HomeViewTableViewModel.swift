//
//  HomeViewTableViewModel.swift
//  RxMvvmTableView
//
//  Created by 김도희 on 2021/07/18.
//

import Foundation

/**
 # HomeViewController TableView ViewModel #
 - author: 김도희
 */
struct HomeViewTableViewModel {
    var id: Int
    var name: String
    var username: String
    var email: String
    var website: String

    init(_ item: User) {
        self.id = item.id
        self.name = item.name
        self.username = item.username
        self.email = item.email
        self.website = item.website
    }

    init(name: String, username: String, email: String, website: String) {
        self.id = 0
        self.name = name
        self.username = username
        self.email = email
        self.website = website
    }

    init() {
        self.init(name: "", username: "", email: "", website: "")
    }
}
