//
//  CollectionView.swift
//  TopGitHub
//
//  Created by Pallavi Anant Dipke on 31/10/21.
//

import Foundation
import UIKit

class CollectionView: UICollectionView {
    var viewModel: GithubRepoListViewModel = GithubRepoListViewModel()
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupCollectionview()
    }
    
    private func registerTableNib() {
        register(cellType: LanguageCollectionCell.self)
    }
    
    private func setupCollectionview() {
        registerTableNib()
        delegate = self
        dataSource = self
        self.showsVerticalScrollIndicator = false
        self.showsHorizontalScrollIndicator = false
        reloadData()
    }
    
    private func setSelectedLanguage(selectedIndex: Int) {
        viewModel.setSelectedFilters(selectedIndex: selectedIndex) { (status) in
            self.performBatchUpdates({
                let indexSet = IndexSet(integersIn: 0...0)
                self.reloadSections(indexSet)
            }, completion: nil)
        }
    }
    
}

// MARK: - CollectionView methods
extension CollectionView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(viewModel.languageModel?.count ?? 0)
        return viewModel.languageModel?.count ?? 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(for: indexPath) as LanguageCollectionCell
        if let data = viewModel.languageModel!.getElement(at: indexPath.row) {
            cell.configureCell(language: data)
        }
        cell.languageSelected = {
            self.setSelectedLanguage(selectedIndex: indexPath.row)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        setSelectedLanguage(selectedIndex: indexPath.row)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let language = viewModel.languageModel?.getElement(at: indexPath.row) else { return .zero }
        let titleWidth = language.language_Name?.size(withAttributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12)]).width ?? 0
        return CGSize(width: titleWidth, height: 30)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
