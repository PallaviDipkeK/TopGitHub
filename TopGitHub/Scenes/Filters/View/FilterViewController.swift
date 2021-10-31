//
//  FilterViewController.swift
//  TopGitHub
//
//  Created by Pallavi Anant Dipke on 28/10/21.
//

import UIKit

class FilterViewController: UIViewController, StoryboardSceneBased {
    static let sceneStoryboard = UIStoryboard(name: "Main", bundle: nil)
    
    @IBOutlet private weak var languageCollectionView: UICollectionView! {
        didSet {
            registerTableNib()
        }
    }
    @IBOutlet private var timePeriodButton: [BorderButton]!
    @IBOutlet private weak var proceedButton: BorderButton!
    @IBOutlet private weak var containerView: UIView!
    var viewModel: GithubRepoListViewModel = GithubRepoListViewModel()
    var filterDataChanged: (() -> Void)?
   
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
    }
    
    fileprivate func initialSetup() {
        languageCollectionView.delegate = self
        languageCollectionView.dataSource = self
        languageCollectionView.reloadData()
        proceedButton.setBorder = true
        containerView.roundCorners(corners: [.topLeft, .topRight], radius: 8)
        timePeriodButton.forEach( {$0.setBorder = true})
        timePeriodButton.first?.isEnabled = true
        viewModel.languageModel?.first?.isSelected = true
        viewModel.setDefaultData()
    }
    
    private func registerTableNib() {
        languageCollectionView.register(cellType: LanguageCollectionCell.self)
    }
    
    private func setSelectedLanguage(selectedIndex: Int) {
        viewModel.setSelectedFilters(selectedIndex: selectedIndex) { (status) in
            self.languageCollectionView.performBatchUpdates({
                let indexSet = IndexSet(integersIn: 0...0)
                self.languageCollectionView.reloadSections(indexSet)
            }, completion: nil)
        }
    }
    
    // MARK: -Button Actions
    @IBAction func timeSelctionAction(_ sender: BorderButton) {
        for button in timePeriodButton {
            if button.tag == sender.tag {
                button.isEnabled = true
                viewModel.filterByTime = button.titleLabel?.text ?? ""
                print(button.titleLabel?.text ?? "")
            } else {
                button.setBorder = true
            }
        }
    }
    
    @IBAction func dismissView(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func submitBtnAction(_ sender: Any) {
        print(viewModel.filterByTime)
        print(viewModel.filterByLanguage)
        filterDataChanged?()
    }
}

// MARK: - CollectionView methods
extension FilterViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(viewModel.languageModel?.count ?? 0)
        return viewModel.languageModel?.count ?? 0
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
