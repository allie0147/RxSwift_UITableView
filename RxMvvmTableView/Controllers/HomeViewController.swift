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
        viewModel = HomeViewModel() // inject ViewModel
        super.init(coder: coder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // cell register
        userTableView.register(UINib(nibName: HomeViewTableViewCell.identifier, bundle: nil),
                               forCellReuseIdentifier: HomeViewTableViewCell.identifier)
        makeTableView()
    }

    private func makeTableView() {
        // setting fetched data into tableview
        viewModel.users
            .asDriver(onErrorJustReturn:
            [HomeViewTableViewModel(name: "",
                                    username: "",
                                    email: "",
                                    website: "")])
            .drive(userTableView.rx.items(
            cellIdentifier: HomeViewTableViewCell.identifier,
            cellType: HomeViewTableViewCell.self
        )) { index, item, cell in
            cell.viewModel.onNext(item)
        }.disposed(by: disposeBag)

        // tableview selected event
        userTableView.rx.itemSelected
            .subscribe(onNext: { [weak self] indexPath in
            self?.userTableView.deselectRow(at: indexPath, animated: true)
            // -TODO: change scene
        }).disposed(by: disposeBag)
        
        
    }
}

