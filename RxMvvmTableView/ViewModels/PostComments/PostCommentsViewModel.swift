//
//  PostCommentsViewModel.swift
//  RxMvvmTableView
//
//  Created by 김도희 on 2021/07/26.
//

import Foundation

class PostCommentsViewModel {

    let disposeBag: DisposeBag
    let comments: PublishRelay<[PostCommentsTableViewModel]>

    let title: String

    init(postId: Int) {
        disposeBag = DisposeBag()
        comments = PublishRelay<[PostCommentsTableViewModel]>()
        self.title = "No. \(postId)"
        fetchComments(postId)
    }

    private func fetchComments(_ postId: Int) {
        APIService.shared.fetchPostComments(postId: postId)
            .map { $0.map { PostCommentsTableViewModel($0) } }
            .debug()
            .bind(to: self.comments)
            .disposed(by: disposeBag)
    }
}
