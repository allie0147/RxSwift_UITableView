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

//    let viewModel: UserPostsViewModel

    override func viewDidLoad() {
        super.viewDidLoad()
        // cell register
        userPostsTableView.register(UINib(nibName: UserPostsViewTableViewCell.identifier, bundle: nil),
                                    forCellReuseIdentifier: UserPostsViewTableViewCell.identifier)

    }
}
