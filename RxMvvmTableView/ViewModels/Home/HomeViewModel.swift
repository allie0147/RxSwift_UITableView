//
//  HomeViewModel.swift
//  RxMvvmTableView
//
//  Created by 김도희 on 2021/07/18.
//

import Foundation

/**
 # Users view model #
 - author: 김도희
 */
class HomeViewModel {
    // RX
    let disposeBag: DisposeBag
    let users: BehaviorRelay<[HomeViewTableViewModel]>

    init() {
        disposeBag = DisposeBag()
        users = BehaviorRelay<[HomeViewTableViewModel]>(value: [])
        // API call
        fetchUsers()
    }

    /**
     # [GET] User Data #
     */
    private func fetchUsers() {
        APIService.shared.fetchUsers()
            .map { $0.map { HomeViewTableViewModel($0) } } // - convert User to HomeViewTableViewModel
            .debug()
            .bind(to: self.users)
            .disposed(by: disposeBag)
    }
}
