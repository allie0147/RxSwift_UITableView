//
//  UserDetailViewController.swift
//  RxMvvmTableView
//
//  Created by 김도희 on 2021/07/25.
//

import UIKit

class UserPostsViewController: UIViewController {

    static let identifier = "UserPostsViewController"

    @IBOutlet weak var userPostsTableView: UITableView!

    var viewModel: UserPostsViewModel! = nil

    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        // cell register
        userPostsTableView.register(UINib(nibName: UserPostsViewTableViewCell.identifier, bundle: nil),
                                    forCellReuseIdentifier: UserPostsViewTableViewCell.identifier)

        // cell data binding
        viewModel.posts
            .asDriver(onErrorJustReturn: [])
            .drive(userPostsTableView.rx.items(cellIdentifier: UserPostsViewTableViewCell.identifier,
                                               cellType: UserPostsViewTableViewCell.self)
        ) { index, item, cell in
            cell.viewModel.accept(item)
        }
            .disposed(by: disposeBag)
    }
}
