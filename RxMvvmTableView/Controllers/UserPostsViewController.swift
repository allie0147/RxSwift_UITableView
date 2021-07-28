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

    var disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.settingUI()

        // cell data binding
        viewModel.posts
            .asDriver(onErrorJustReturn: [])
            .drive(userPostsTableView.rx.items(cellIdentifier: UserPostsViewTableViewCell.identifier,
                                               cellType: UserPostsViewTableViewCell.self)
        ) { index, item, cell in
            cell.viewModel.accept(item)
        }
            .disposed(by: disposeBag)

        Observable.zip(userPostsTableView.rx.itemSelected,
                       userPostsTableView.rx.modelSelected(UserPostsViewTableViewModel.self)
        ).bind { [weak self] in
            self?.userPostsTableView.deselectRow(at: $0.0, animated: true)
            // push VC
            let storyboard = UIStoryboard.getSB(name: .main)
            let vc = storyboard.instantiateViewController(withIdentifier: PostCommentsViewController.identifier) as! PostCommentsViewController
            vc.viewModel = PostCommentsViewModel(postId: Int($0.1.id) ?? 0)
            self?.navigationController?.pushViewController(vc, animated: true)
        }.disposed(by: disposeBag)
    }
    
    func settingUI() {
        // navigation bar
        self.navigationItem.largeTitleDisplayMode = .never
        self.navigationItem.title = viewModel.username
        // table view
        userPostsTableView.register(UINib(nibName: UserPostsViewTableViewCell.identifier, bundle: nil),
                                    forCellReuseIdentifier: UserPostsViewTableViewCell.identifier)
        userPostsTableView.estimatedRowHeight = 100
        userPostsTableView.rowHeight = 110
    }
}
