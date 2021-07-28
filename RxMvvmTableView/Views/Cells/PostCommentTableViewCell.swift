//
//  PostCommentTableViewCell.swift
//  RxMvvmTableView
//
//  Created by 김도희 on 2021/07/28.
//

import UIKit

class PostCommentTableViewCell: UITableViewCell {
    static let identifier = "PostCommentTableViewCell"

    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var lbComment: UILabel!

    let viewModel: PublishRelay<PostCommentsTableViewModel>
    var disposeBag = DisposeBag()

    required init?(coder: NSCoder) {
        self.viewModel = PublishRelay<PostCommentsTableViewModel>()
        super.init(coder: coder)
        bind(with: viewModel)
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
    }

    /**
     - bind cellViewModel
     
     - parameters:
     - data: PublishRelay<PostCommentsTableViewModel>
     - Returns: void
     - authors: 김도희
     */
    private func bind(with data: PublishRelay<PostCommentsTableViewModel>) {
        data.asDriver(onErrorJustReturn: PostCommentsTableViewModel())
            .drive(onNext: { [weak self] value in
            self?.lbName.text = value.name
            self?.lbComment.text = value.body
        }).disposed(by: disposeBag)
    }
}
