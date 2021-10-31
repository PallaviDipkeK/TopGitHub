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
    @IBOutlet private weak var repoTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.setDefaultData()
        getReposApiCall()
        registerCells()
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
    
    func didSelectRow(data: GithubRepoListModel.Item?) {
        let detailVC = RepoDetailViewController.instantiate()
        detailVC.setupData(data: data)
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
    
    func registerCells() {
        setUpNavigationItem(title: "GitHub", left: nil, primaryRight: .filter)
        repoTableView.register(cellType: GitRepoListTableViewCell.self)
    }
    
    private func getReposApiCall() {
//        activityIndicatorBegin()
        viewModel.callListApi(completionHandler: { [weak self] (status) in
            self?.handleAPiResponse(status)
        })
    }
    
    fileprivate func handleAPiResponse(_ status: Bool) {
//        activityIndicatorEnd()
        if status {
            repoTableView.delegate = self
            repoTableView.dataSource = self
            repoTableView.reloadData()
        } else {
            showToast(message: "Something went wrong.")
        }
    }
}

extension GitHubListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.model?.items?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath) as GitRepoListTableViewCell
        let data = viewModel.model?.items?[indexPath.row]
        cell.configureCell(data: data)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        didSelectRow(data: viewModel.model?.items?[indexPath.row])
    }
}

