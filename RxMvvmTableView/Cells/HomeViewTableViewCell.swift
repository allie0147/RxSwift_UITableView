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

    var viewModel: PublishRelay<HomeViewTableViewModel>
    let cellDisposeBag = DisposeBag()

    required init?(coder: NSCoder) {
        let data = PublishRelay<HomeViewTableViewModel>()
        viewModel = data

        super.init(coder: coder)

        self.bind(with: data)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    /**
     - bind cellViewModel
     
     - parameters:
        - data: PublishSubject<HomeViewTableViewModel>
     - Returns: void
     - authors: 김도희
     */
    func bind(with data: PublishRelay<HomeViewTableViewModel>) {
        data.observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] data in
            self?.lbUsername.text = data.username
            self?.lbName.text = data.name
            self?.lbEmail.text = data.email
            self?.lbWebsite.text = data.website
        })
            .disposed(by: cellDisposeBag)
    }
}
