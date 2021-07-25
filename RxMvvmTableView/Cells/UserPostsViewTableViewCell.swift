//
//  UserPostsViewTableViewCell.swift
//  RxMvvmTableView
//
//  Created by 김도희 on 2021/07/25.
//

import UIKit

class UserPostsViewTableViewCell: UITableViewCell {

    static let identifier = "UserPostsViewTableViewCell"

    @IBOutlet weak var lbNumber: UILabel!
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var lbBody: UILabel!

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
