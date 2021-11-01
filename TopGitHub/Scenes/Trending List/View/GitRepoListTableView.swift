//
//  GitRepoListTableView.swift
//  TopGitHub
//
//  Created by Pallavi Anant Dipke on 31/10/21.
//

import UIKit

class GitRepoListTableView: UITableView {
    
    // MARK: - Properties
    var viewModel: GithubRepoListViewModel = GithubRepoListViewModel()
    var didSelectRow: ((GithubRepoListModel.Item?) -> Void)?
    
    // MARK: - View life cycle methods
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupTablview()
    }
    
    private func registerCells() {
        register(cellType: GitRepoListTableViewCell.self)
    }
    
    private func setupTablview() {
        delegate = self
        dataSource = self
        showsVerticalScrollIndicator = false
        allowsSelection = true
        registerCells()
    }
    
    private func updateTableView() {
        beginUpdates()
        endUpdates()
    }
}

extension GitRepoListTableView: UITableViewDelegate, UITableViewDataSource {
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
        cell.viewMoreSelected = {
            self.didSelectRow?(data)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        didSelectRow?(viewModel.model?.items?[indexPath.row] ?? nil)
    }
}
