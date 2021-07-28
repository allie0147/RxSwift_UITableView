//
//  PostCommentTableViewHeader.swift
//  RxMvvmTableView
//
//  Created by 김도희 on 2021/07/28.
//

import UIKit

class PostCommentTableViewHeaderView: UIView {
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var lbBody: UILabel!

    var userPost: PublishRelay<UserPost>

    var disposeBag = DisposeBag()

    override init(frame: CGRect) {
        userPost = PublishRelay<UserPost>()
        super.init(frame: frame)
        commonInit()
        bind(with: userPost)
    }

    private func commonInit() {
        let view = Bundle.main.loadNibNamed(String(describing: PostCommentTableViewHeaderView.self), owner: self, options: nil)?.first as! PostCommentTableViewHeaderView
        view.frame = self.bounds
        self.addSubview(view)
    }

    required init?(coder: NSCoder) {
        userPost = PublishRelay<UserPost>()
        super.init(coder: coder)
    }

    private func bind(with data: PublishRelay<UserPost>) {
        data.asDriver(onErrorJustReturn: UserPost(userId: 0, id: 0, title: "", body: ""))
            .debug()
            .drive(onNext: { [weak self] value in
            self?.lbTitle.text = value.title
            self?.lbBody.text = value.body
        }).disposed(by: disposeBag)
    }
}

