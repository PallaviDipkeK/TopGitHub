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
    @IBOutlet weak var repoTableView: GitRepoListTableView!
    lazy var refreshControl: CustomRefreshControl = CustomRefreshControl()

    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    // MARK: - Refresh Controls
    private func createRefreshControl() {
        refreshControl.createCustomControl { [weak self] in
            self?.viewModel.model = nil
            self?.getReposApiCall()
        }
    }
    
    override func didTapRightBarbutton(_ buttonType: NavigationBarButtonType?, sender: Any) {
        let filterView = FilterViewController.instantiate()
        filterView.viewModel = viewModel
        filterView.filterDataChanged = { [weak self] in
            DispatchQueue.main.async {
                filterView.dismiss(animated: true, completion: {
                    self?.getReposApiCall()
                })
            }
        }
        filterView.modalPresentationStyle = .overFullScreen
        filterView.modalTransitionStyle = .crossDissolve
        self.navigationController?.present(filterView, animated: true, completion: nil)
    }
    
    fileprivate func initialSetup() {
        setUpNavigationItem(title: "GitHub", left: nil, primaryRight: .filter)
        repoTableView.refreshControl = refreshControl
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
        detailVC.link = data?.repoLink ?? "https://trendings.herokuapp.com/repo"
        detailVC.setupData(data: data)
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
    
    private func getReposApiCall() {
        activityIndicatorBegin()
        viewModel.callListApi(completionHandler: { [weak self] (status, msg)  in
            DispatchQueue.main.async {
                self?.handleAPiResponse(status, msg: msg ?? "")
            }
        })
    }
    
    fileprivate func presentAlert(_ msg: String) {
        presentAlertWithTitle(title: "Opps!", message: msg, options: "Retry", "Cancel") { (option) in
            print("option: \(option)")
            switch(option) {
            case 0:
                if !BaseServiceClass.sharedInstance.isConnectedToInternet() {
                    self.presentAlert("No Network Available")
                } else {
                    self.getReposApiCall()
                }
            case 1:
                print("option two")
                self.dismiss(animated: true, completion: nil)
            default:
                break
            }
        }
    }
    
    fileprivate func handleAPiResponse(_ status: Bool, msg: String) {
        refreshControl.endRefreshing()
        activityIndicatorEnd()
        if status {
            repoTableView.reloadData()
        } else {
            presentAlert(msg)
        }
    }
}

