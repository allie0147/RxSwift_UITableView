//
//  PostCommentsViewModel.swift
//  RxMvvmTableView
//
//  Created by 김도희 on 2021/07/26.
//

import Foundation

class PostCommentsViewModel {

    let disposeBag: DisposeBag

//    let comments: PublishRelay<[]>

    init(postId: Int) {
        disposeBag = DisposeBag()

    }
    
    private func fetchComments(_ postId: Int) {
        APIService.shared.fetchPostComments(postId: postId)
//            .map(<#T##transform: ([UserPost]) throws -> Result##([UserPost]) throws -> Result#>)
//            .bind(to: <#T##[UserPost]...##[UserPost]#>)
    }
}
