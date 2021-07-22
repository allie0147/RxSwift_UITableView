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

        fetchUsers()
    }

    func fetchUsers() {
        APIService.shared.fetchUsers()
            .map { $0.map { HomeViewTableViewModel($0) } }
            .debug()
            .bind(to: self.users)
            .disposed(by: disposebag)
    }
}
