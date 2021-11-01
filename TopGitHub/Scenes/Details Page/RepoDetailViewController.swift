//
//  RepoDetailViewController.swift
//  TopGitHub
//
//  Created by Pallavi Anant Dipke on 31/10/21.
//

import UIKit
import SDWebImage
class RepoDetailViewController: BaseViewController, StoryboardSceneBased {
    
    @IBOutlet private weak var repoAvatatImage: UIImageView!
    @IBOutlet private weak var langLabel: UILabel!
    @IBOutlet private weak var forkLabel: UILabel!
    @IBOutlet private weak var totalStarsLabel: UILabel!
    @IBOutlet private weak var addedStarsLabel: UILabel!
    @IBOutlet private weak var repoNameLabel: UILabel!
    @IBOutlet private weak var repoLinkLabel: UILabel!
    @IBOutlet private weak var repoDescLabel: UILabel!
    static let sceneStoryboard = UIStoryboard(name: "Main", bundle: nil)
    var link: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavigationItem(title: "Details", subtitle: nil, left: .back, primaryRight: .share)
    }
    
    override func didTapRightBarbutton(_ buttonType: NavigationBarButtonType?, sender: Any) {
        shareLink(link)
    }
    
    func setupData(data: GithubRepoListModel.Item?) {
        repoAvatatImage.sd_setImage(with: URL.init(string: data?.avatars?.last ?? ""), completed: nil)
        let language = String(format: "Language:- \(data?.lang ?? "")")
        let attributedLanguageString = NSMutableAttributedString(string: language)
        langLabel.attributedText = attributedLanguageString.highlightedSubstring(
            "Language:- ",
            withFont: AppFont.semiBold.size(13.0),
            color: .white)
        
        let fork = String(format: "Fork:- \(data?.forks ?? "")")
        let attributedForkString = NSMutableAttributedString(string: fork)
        forkLabel.attributedText = attributedForkString.highlightedSubstring(
            "Fork:- ",
            withFont: AppFont.semiBold.size(13.0),
            color: .white)
        
        let totalStars = String(format: "Total Stars:- \(data?.stars ?? "")")
        let attributeTotalStarsString = NSMutableAttributedString(string: totalStars)
        totalStarsLabel.attributedText = attributeTotalStarsString.highlightedSubstring(
            "Total Stars:- ",
            withFont: AppFont.semiBold.size(13.0),
            color: .white)
        
        let addedStarts = String(format: "Added Stars:- \(data?.addedStars ?? "")")
        let attributedAddedStartsString = NSMutableAttributedString(string: addedStarts)
        addedStarsLabel.attributedText = attributedAddedStartsString.highlightedSubstring(
            "Added Stars:- ",
            withFont: AppFont.semiBold.size(13.0),
            color: .white)
        
        let repoName = String(format: "Repo Name:- \(data?.repo ?? "")")
        let attributedRepoNameString = NSMutableAttributedString(string: repoName)
        repoNameLabel.attributedText = attributedRepoNameString.highlightedSubstring(
            "Repo Name:- ",
            withFont: AppFont.semiBold.size(13.0),
            color: .white)
        
        let link = String(format: "Link:- \(data?.repoLink ?? "")")
        let attributedLinkString = NSMutableAttributedString(string: link)
        repoLinkLabel.attributedText = attributedLinkString.highlightedSubstring(
            "Link:- ",
            withFont: AppFont.semiBold.size(13.0),
            color: .white)
        
        let description = String(format: "Description:- \(data?.desc ?? "")")
        let attributedDescriptionString = NSMutableAttributedString(string: description)
        repoDescLabel.attributedText = attributedDescriptionString.highlightedSubstring(
            "Description:- ",
            withFont: AppFont.semiBold.size(13.0),
            color: .white)
    }
    
}
