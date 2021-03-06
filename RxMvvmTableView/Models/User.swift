//
//  User.swift
//  RxMvvmTableView
//
//  Created by 김도희 on 2021/07/18.
//

import Foundation

/**
 # User Model #
 - note: [/users/{id}](/)
 - author: 김도희
 */
struct User: Codable {
    var id: Int
    var name: String
    var username: String
    var email: String
    var phone: String
    var website: String
}
