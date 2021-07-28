//
//  HomeViewTableViewCell.swift
//  RxMvvmTableView
//
//  Created by 김도희 on 2021/07/18.
//

import UIKit

class HomeViewTableViewCell: UITableViewCell {

    static let identifier: String = "HomeViewTableViewCell"

    @IBOutlet weak var lbUsername: UILabel!
    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var lbEmail: UILabel!
    @IBOutlet weak var lbWebsite: UILabel!

    let viewModel: PublishRelay<HomeViewTableViewModel>
    var cellDisposeBag = DisposeBag()

    required init?(coder: NSCoder) {
        viewModel = PublishRelay<HomeViewTableViewModel>()

        super.init(coder: coder)

        self.bind(with: viewModel)
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        cellDisposeBag = DisposeBag()
    }

    /**
     - bind cellViewModel
     
     - parameters:
        - data: PublishSubject<HomeViewTableViewModel>
     - Returns: void
     - authors: 김도희
     */
    func bind(with data: PublishRelay<HomeViewTableViewModel>) {
        data.asDriver(onErrorJustReturn: HomeViewTableViewModel())
            .drive(onNext: { [weak self] data in
            self?.lbUsername.text = data.username
            self?.lbName.text = data.name
            self?.lbEmail.text = data.email
            self?.lbWebsite.text = data.website
        })
            .disposed(by: cellDisposeBag)
    }
}
