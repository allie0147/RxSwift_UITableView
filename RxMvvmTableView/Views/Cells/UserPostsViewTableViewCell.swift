//
//  UserPostsViewTableViewCell.swift
//  RxMvvmTableView
//
//  Created by 김도희 on 2021/07/25.
//

import UIKit

class UserPostsViewTableViewCell: UITableViewCell {

    static let identifier = "UserPostsViewTableViewCell"

    @IBOutlet weak var lbNumber: UILabel!
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var lbBody: UILabel!

    let viewModel: PublishRelay<UserPostsViewTableViewModel>

    var disposeBag = DisposeBag()

    required init?(coder: NSCoder) {
        self.viewModel = PublishRelay<UserPostsViewTableViewModel>()
        super.init(coder: coder)

        self.bind(with: viewModel)
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
    }

    /**
     - bind cellViewModel
     
     - parameters:
        - data: PublishRelay<UserPostsViewTableViewModel>
     - Returns: void
     - authors: 김도희
     */
    private func bind(with data: PublishRelay<UserPostsViewTableViewModel>) {
        data.asDriver(onErrorJustReturn: UserPostsViewTableViewModel())
            .drive(onNext: { [weak self] value in
            self?.lbNumber.text = "No.\(value.id)"
            let attrString = NSAttributedString(string: value.title,
                                                attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17, weight: .bold)])
            self?.lbTitle.attributedText = attrString
            self?.lbBody.text = value.body
        }).disposed(by: disposeBag)
    }

}
