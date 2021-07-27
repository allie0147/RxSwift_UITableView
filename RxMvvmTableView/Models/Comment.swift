//
//  Comments.swift
//  RxMvvmTableView
//
//  Created by 김도희 on 2021/07/26.
//

import Foundation
/**
 # Comment Model #
 - note: [/posts/{postId}/comments](/)
 - author: 김도희
 */
struct Comment: Codable {
    var postId: Int
    var id: Int
    var name: String
    var email: String
    var body: String
}
