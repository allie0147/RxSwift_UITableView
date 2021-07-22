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
    let tableViewModel: HomeViewTableViewModel

    let disposeBag: DisposeBag = DisposeBag()

    required init?(coder: NSCoder) {
        viewModel = HomeViewModel()
        tableViewModel = HomeViewTableViewModel()
        super.init(coder: coder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        userTableView.register(UINib(nibName: HomeViewTableViewCell.identifier, bundle: nil),
                               forCellReuseIdentifier: HomeViewTableViewCell.identifier)

        viewModel.users
            .asDriver(onErrorJustReturn: [User(id: 0,
                                               name: "Demo",
                                               username: "DemoName",
                                               email: "demo@gmail.com",
                                               phone: "000-0000-0000",
                                               website: "www.demo.com")])
            .drive(userTableView.rx.items(
            cellIdentifier: HomeViewTableViewCell.identifier, cellType: HomeViewTableViewCell.self
        )) { index, item, cell in
            cell.lbName.text = item.name
            cell.lbUsername.text = item.username
            cell.lbEmail.text = item.email
            cell.lbWebsite.text = item.website
        }.disposed(by: disposeBag)

        userTableView.rx.itemSelected
            .subscribe(onNext: { [weak self] indexPath in
            self?.userTableView.deselectRow(at: indexPath, animated: true)
        }).disposed(by: disposeBag)

    }
}

