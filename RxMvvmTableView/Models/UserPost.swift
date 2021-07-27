//
//  UserPost.swift
//  RxMvvmTableView
//
//  Created by 김도희 on 2021/07/25.
//

import Foundation

/**
 # Post Model #
 - note: [/users/{id}/posts](/)
 - author: 김도희
 */
struct UserPost: Codable {
    var userId: Int
    var id: Int
    var title: String
    var body: String
}
