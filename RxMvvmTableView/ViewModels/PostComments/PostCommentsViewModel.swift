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
    let post: PublishRelay<UserPost>

    let title: String

    init(postId: Int) {
        disposeBag = DisposeBag()
        comments = PublishRelay<[PostCommentsTableViewModel]>()
        post = PublishRelay<UserPost>()

        self.title = "Number".localized(with: String(postId))

        fetchComments(postId)
        fetchPost(postId)
    }

    private func fetchComments(_ postId: Int) {
        APIService.shared.fetchPostComments(postId: postId)
            .map { $0.map { PostCommentsTableViewModel($0) } }
            .debug()
            .bind(to: self.comments)
            .disposed(by: disposeBag)
    }

    private func fetchPost(_ postId: Int) {
        APIService.shared.fetchPost(postId: postId)
            .debug()
            .bind(to: self.post)
            .disposed(by: disposeBag)
    }
}
