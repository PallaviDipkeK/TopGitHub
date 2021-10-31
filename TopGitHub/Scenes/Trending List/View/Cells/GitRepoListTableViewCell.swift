//
//  GitRepoListTableViewCell.swift
//  TopGitHub
//
//  Created by Pallavi Anant Dipke on 28/10/21.
//

import UIKit
import SDWebImage

class GitRepoListTableViewCell: UITableViewCell, NibReusable {
    @IBOutlet private weak var nameLabel: UILabel?
    @IBOutlet private weak var repoNameLabel: UILabel?
    @IBOutlet private weak var authorImageView: UIImageView?
    @IBOutlet private weak var viewMoreButton: UIButton?
    
    var viewMoreSelected:(() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureCell(data: GithubRepoListModel.Item?) {
        nameLabel?.text = data?.repo
        repoNameLabel?.text = data?.desc
        authorImageView?.sd_setImage(with: URL(string: data?.avatars?.last ?? ""), completed: nil)
    }
    
    @IBAction func viewMoreClicked(_ sender: Any) {
        viewMoreSelected?()
    }    
}
