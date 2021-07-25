//
//  UserDetailViewController.swift
//  RxMvvmTableView
//
//  Created by 김도희 on 2021/07/25.
//

import UIKit

class UserPostsViewController: UIViewController {

    @IBOutlet weak var userPostsTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // cell register
        userPostsTableView.register(UINib(nibName: UserPostsViewTableViewCell.identifier, bundle: nil),
                                    forCellReuseIdentifier: UserPostsViewTableViewCell.identifier)
        
        
        

    }

}
