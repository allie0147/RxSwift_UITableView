//
//  PostCommnetsViewController.swift
//  RxMvvmTableView
//
//  Created by 김도희 on 2021/07/26.
//

import UIKit

class PostCommentsViewController: UIViewController {

    static let identifier = "PostCommentsViewController"

    // MARK: -UI
    @IBOutlet weak var postCommentTableView: UITableView!
    private var makeCommentButton: UIButton = { // floating
        let button = UIButton(
            frame: CGRect(
                x: 0,
                y: 0,
                width: 60,
                height: 60
            ))
        // Icon
        let image = UIImage(named: "plus")
        button.setImage(image, for: .normal)
        // Colors
        button.backgroundColor = .systemPink
        button.tintColor = .white
        button.setTitleColor(.white, for: .normal)
        // Shadow
        button.layer.shadowOpacity = 0.3
        button.layer.shadowPath = UIBezierPath(
            roundedRect: CGRect(
                x: 0,
                y: 5,
                width: 60 + 5,
                height: 60
            ),
            cornerRadius: 30
        ).cgPath
        button.layer.shouldRasterize = true // cache the rendered shadow
        // Corner radius
        button.layer.cornerRadius = 30
        return button
    }()

    // MARK: -Rx
    var viewModel: PostCommentsViewModel! = nil
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        settingUI()

    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        makeCommentButton.frame = CGRect(
            x: view.frame.size.width - 60 - 15, // view.width - button width - little margin
            y: view.frame.size.height - 60 - view.safeAreaInsets.bottom, // view.height - button height - safeArea.bottom
            width: 60,
            height: 60
        )
        print("makeCommentButton \(makeCommentButton)")
    }


    func settingUI() {
        // navigation item
        self.navigationItem.largeTitleDisplayMode = .never
        self.navigationItem.title = viewModel.title
        
        view.addSubview(makeCommentButton) 

        makeCommentButton.rx.tap
            .bind(onNext: { [weak self] in
            print("button tapped")
            let storyboard = UIStoryboard(name: "main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: CommentViewController.identifier) as! CommentViewController
            self?.present(vc, animated: true)
        })
            .disposed(by: disposeBag)
    }
}
