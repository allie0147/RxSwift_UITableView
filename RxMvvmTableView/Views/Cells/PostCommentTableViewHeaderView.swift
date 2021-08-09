//
//  PostCommentTableViewHeader.swift
//  RxMvvmTableView
//
//  Created by 김도희 on 2021/07/28.
//

import UIKit

class PostCommentTableViewHeaderView: UIView {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var backgroundImageView: UIImageView!

    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var lbBody: UILabel!

    @IBOutlet weak var containerHeight: NSLayoutConstraint!

    @IBOutlet weak var imageViewHeight: NSLayoutConstraint!
    @IBOutlet weak var imageViewBottom: NSLayoutConstraint!

    var userPost: BehaviorRelay<UserPost>
    var headerHeight: PublishRelay<CGFloat>
    var disposeBag = DisposeBag()

    override init(frame: CGRect) {
        userPost = BehaviorRelay<UserPost>(value: UserPost(userId: 0, id: 0, title: "", body: ""))
        headerHeight = PublishRelay<CGFloat>()
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
        userPost = BehaviorRelay<UserPost>(value: UserPost(userId: 0, id: 0, title: "", body: ""))
        headerHeight = PublishRelay<CGFloat>()
        super.init(coder: coder)
    }

    private func bind(with data: BehaviorRelay<UserPost>) {
        data.asDriver(onErrorJustReturn: UserPost(userId: 0, id: 0, title: "", body: ""))
            .debug()
            .drive(onNext: { [weak self] value in
            self?.lbTitle.text = value.title
            self?.lbBody.text = value.body
        }).disposed(by: disposeBag)
    }

    /// notify view of scroll change from container
    func scrollViewDidScroll(scrollView: UIScrollView) {
        containerHeight.constant = scrollView.contentInset.top
        let offsetY = -(scrollView.contentOffset.y + scrollView.contentInset.top)
        containerView.clipsToBounds = offsetY <= 0
        imageViewHeight.constant = max(offsetY + scrollView.contentInset.top, scrollView.contentInset.top)
    }
}

