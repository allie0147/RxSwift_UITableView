//
//  PostCommnetsViewController.swift
//  RxMvvmTableView
//
//  Created by 김도희 on 2021/07/26.
//

import UIKit
import RxViewController

class PostCommentsViewController: UIViewController {

    static let identifier = "PostCommentsViewController"

    // MARK: -UI
    @IBOutlet weak var postCommentTableView: UITableView!
    // Floating Action Button
    private lazy var makeCommentButton: UIButton = {
        let button = UIButton(
            frame: CGRect(
                x: 0,
                y: 0,
                width: 60,
                height: 60
            ))
        // Icon
//        let image = UIImage(systemName: "plus")
//        button.setImage(image, for: .normal)
        // title
        button.setTitle("+", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 40, weight: .bold)
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
//    private lazy var tableHeaderView: PostCommentTableViewHeaderView = {
//        return PostCommentTableViewHeaderView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 300))
//    }()

    var kTableHeaderHeight: CGFloat = 300.0

    // MARK: -Rx
    var viewModel: PostCommentsViewModel! = nil
    var disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        settingUI()

        let header = PostCommentTableViewHeader(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 300))
        header.imageView.image = UIImage(named: "background")
        postCommentTableView.tableHeaderView = header
    }

    func settingUI() {
        // navigation item
        self.navigationItem.largeTitleDisplayMode = .never
        self.navigationItem.title = viewModel.title

        // add FAB
        view.addSubview(makeCommentButton)

        // cell
        postCommentTableView.register(UINib(nibName: PostCommentTableViewCell.identifier, bundle: nil),
                                      forCellReuseIdentifier: PostCommentTableViewCell.identifier)


        // header view
//        postCommentTableView.estimatedRowHeight = UITableView.automaticDimension
//        postCommentTableView.tableHeaderView = self.tableHeaderView

        // FAB
        makeCommentButton.rx.tap
            .bind(onNext: { [weak self] in
            print("button tapped")
            let storyboard = UIStoryboard.getSB(name: .main)
            let vc = storyboard.instantiateViewController(withIdentifier: CommentViewController.identifier) as! CommentViewController
            self?.present(vc, animated: true)
        })
            .disposed(by: disposeBag)

        self.rx.viewDidLayoutSubviews
            .subscribe(onNext: { [weak self] in
            self?.setFABFrame()
        }).disposed(by: disposeBag)

        // commetns in tableView
        viewModel.comments.asDriver(onErrorJustReturn: [])
            .drive(postCommentTableView.rx.items(
            cellIdentifier: PostCommentTableViewCell.identifier,
            cellType: PostCommentTableViewCell.self)
        ) { index, item, cell in
            cell.viewModel.accept(item)
        }.disposed(by: disposeBag)

        viewModel.post.asDriver(onErrorJustReturn: UserPost(userId: 0, id: 0, title: "", body: ""))
            .drive(onNext: { [weak self] data in
//            self?.tableHeaderView.userPost.accept(data)
        })
            .disposed(by: disposeBag)

        postCommentTableView.rx.didScroll.asDriver(
        ).drive(onNext: { [weak self] in
            guard let header = self?.postCommentTableView.tableHeaderView as? PostCommentTableViewHeader else { return }
            header.scrollViewDidScroll(scrollView: (self?.postCommentTableView)!)
//            self?.updateHeaderView()
        })
            .disposed(by: disposeBag)
    }

//    func updateHeaderView() {
//        var headerRect = CGRect(x: 0, y: -kTableHeaderHeight, width: postCommentTableView.bounds.width, height: kTableHeaderHeight)
//        if postCommentTableView.contentOffset.y < -kTableHeaderHeight {
//            headerRect.origin.y = postCommentTableView.contentOffset.y
//            headerRect.size.height = -postCommentTableView.contentOffset.y
//        }
//        tableHeaderView.frame = headerRect
//    }

    private func setFABFrame() {
        makeCommentButton.frame = CGRect(
            x: view.frame.size.width - 60 - 15, // view.width - button width - little margin
            y: view.frame.size.height - 60 - view.safeAreaInsets.bottom, // view.height - button height - safeArea.bottom
            width: 60,
            height: 60
        )
    }
}
