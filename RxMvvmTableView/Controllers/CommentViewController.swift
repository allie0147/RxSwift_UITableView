//
//  CommentViewController.swift
//  RxMvvmTableView
//
//  Created by 김도희 on 2021/07/27.
//

import UIKit
class CommentViewController: UIViewController {

    static let identifier = "CommentViewController"

    @IBOutlet weak var tfId: UITextField!
    @IBOutlet weak var tfEmail: UITextField!
    @IBOutlet weak var tvBody: UITextView!
    @IBOutlet weak var buttonSave: UIButton!
    
    var testComment: PublishRelay<Comment> = PublishRelay<Comment>()
    var disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

//        APIService.shared.postComment(comment: Comment(postId: 1, id: 1, name: "name", email: "email", body: "bodybody"))
//            .debug().bind(to: testComment).disposed(by: disposeBag)
    }

}
