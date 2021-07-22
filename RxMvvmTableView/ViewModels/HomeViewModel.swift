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
    let users: BehaviorRelay<[User]>

    init() {
        disposebag = DisposeBag()
        users = BehaviorRelay<[User]>(value: [])

        fetchUsers()
    }

    func fetchUsers() {
        APIService.shared.fetchUsers()
            .debug()
            .bind(to: self.users)
            .disposed(by: disposebag)
    }
}
