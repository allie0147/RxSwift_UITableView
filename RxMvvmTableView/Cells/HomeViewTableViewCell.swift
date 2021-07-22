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

    var viewModel: AnyObserver<HomeViewTableViewModel>
    let cellDisposeBag = DisposeBag()

    required init?(coder: NSCoder) {
        let data = PublishSubject<HomeViewTableViewModel>()
        viewModel = data.asObserver()

        super.init(coder: coder)

        data.observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] data in
            self?.lbUsername.text = data.username
            self?.lbName.text = data.name
            self?.lbEmail.text = data.email
            self?.lbWebsite.text = data.website
        })
            .disposed(by: cellDisposeBag)

    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func bind(to viewModel: HomeViewTableViewModel) {
        lbUsername.text = viewModel.username
        lbName.text = viewModel.name
        lbEmail.text = viewModel.email
        lbWebsite.text = viewModel.website
    }
}
