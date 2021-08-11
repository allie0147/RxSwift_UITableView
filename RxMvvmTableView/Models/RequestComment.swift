//
//  RequestComment.swift
//  RxMvvmTableView
//
//  Created by 김도희 on 2021/08/11.
//

import Foundation
/**
 # Request Comment Model #
 - note: [/comments](/)
 - author: 김도희
 */
struct RequestComment: Codable {
    var postId: String
    var id: String
    var name: String
    var email: String
    var body: String
}
