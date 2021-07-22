//
//  ViewController.swift
//  RxMvvmTableView
//
//  Created by 김도희 on 2021/07/18.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var userTableView: UITableView!

    let viewModel: HomeViewModel

    let disposeBag: DisposeBag = DisposeBag()

    required init?(coder: NSCoder) {
        viewModel = HomeViewModel()
        super.init(coder: coder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        userTableView.register(UINib(nibName: HomeViewTableViewCell.identifier, bundle: nil),
                               forCellReuseIdentifier: HomeViewTableViewCell.identifier)

        viewModel.users
            .asDriver(onErrorJustReturn: [HomeViewTableViewModel(name: "",
                                                                 username: "",
                                                                 email: "",
                                                                 website: "")]
            )
            .drive(userTableView.rx.items(
            cellIdentifier: HomeViewTableViewCell.identifier,
            cellType: HomeViewTableViewCell.self
        )) { index, item, cell in
            cell.viewModel.onNext(item)
//            cell.bind(to:
//                HomeViewTableViewModel(name: item.name,
//                                       username: item.username,
//                                       email: item.email,
//                                       website: item.website)
//            )
        }.disposed(by: disposeBag)

        userTableView.rx.itemSelected
            .subscribe(onNext: { [weak self] indexPath in
            self?.userTableView.deselectRow(at: indexPath, animated: true)
        }).disposed(by: disposeBag)

    }
}

