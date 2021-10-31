//
//  FilterViewController.swift
//  TopGitHub
//
//  Created by Pallavi Anant Dipke on 28/10/21.
//

import UIKit

class FilterViewController: UIViewController, StoryboardSceneBased {
    static let sceneStoryboard = UIStoryboard(name: "Main", bundle: nil)
    
    @IBOutlet private weak var languageCollectionView: CollectionView!
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
        viewModel.setDefaultData()
        proceedButton.isEnabled = true
        containerView.roundCorners(corners: [.topLeft, .topRight], radius: 8)
        timePeriodButton.forEach( {$0.setBorder = true})
        timePeriodButton.first?.isEnabled = true
        viewModel.languageModel?.first?.isSelected = true
        languageCollectionView.viewModel = viewModel
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

