//
//  GitHubListViewController.swift
//  TopGitHub
//
//  Created by Pallavi Anant Dipke on 27/10/21.
//

import UIKit

class GitHubListViewController: BaseViewController, StoryboardSceneBased {
    static let sceneStoryboard = UIStoryboard(name: "Main", bundle: nil)
    var viewModel: GithubRepoListViewModel = GithubRepoListViewModel()
    @IBOutlet private weak var repoTableView: GitRepoListTableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func didTapRightBarbutton(_ buttonType: NavigationBarButtonType?, sender: Any) {
        let filterView = FilterViewController.instantiate()
        filterView.viewModel = viewModel
        filterView.filterDataChanged = { [weak self] in
            filterView.dismiss(animated: true, completion: {
                self?.getReposApiCall()
            })
        }
        filterView.modalPresentationStyle = .overFullScreen
        filterView.modalTransitionStyle = .crossDissolve
        self.navigationController?.present(filterView, animated: true, completion: nil)
    }
    
    fileprivate func initialSetup() {
        setUpNavigationItem(title: "GitHub", left: nil, primaryRight: .filter)
        repoTableView.viewModel = viewModel
        viewModel.setDefaultData()
        getReposApiCall()
        repoTableView.didSelectRow = { [weak self] data in
            DispatchQueue.main.async {
                self?.didSelectRow(data: data)
            }
        }
    }
    
    func didSelectRow(data: GithubRepoListModel.Item?) {
        let detailVC = RepoDetailViewController.instantiate()
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
    
    private func getReposApiCall() {
        activityIndicatorBegin()
        viewModel.callListApi(completionHandler: { [weak self] (status) in
            self?.handleAPiResponse(status)
        })
    }
    
    fileprivate func handleAPiResponse(_ status: Bool) {
        activityIndicatorEnd()
        if status {
            repoTableView.reloadData()
        } else {
            showToast(message: "Something went wrong.")
        }
    }
}

