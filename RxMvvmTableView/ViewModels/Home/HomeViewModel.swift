//
//  HomeViewModel.swift
//  RxMvvmTableView
//
//  Created by 김도희 on 2021/07/18.
//

import Foundation

class HomeViewModel {
    // RX
    let disposebag: DisposeBag
    let users: BehaviorRelay<[HomeViewTableViewModel]>

    init() {
        disposebag = DisposeBag()
        users = BehaviorRelay<[HomeViewTableViewModel]>(value: [])
        // API call
        fetchUsers()
    }

    /**
     # [GET] User Data #
     */
    func fetchUsers() {
        APIService.shared.fetchUsers()
            .map { $0.map { HomeViewTableViewModel($0) } } // - convert User to HomeViewTableViewModel
            .debug()
            .bind(to: self.users)
            .disposed(by: disposebag)
    }
}
