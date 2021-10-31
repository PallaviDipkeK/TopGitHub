//
//  CustomRefreshControl.swift
//  TopGitHub
//
//  Created by Pallavi Anant Dipke on 31/10/21.
//

import UIKit

class CustomRefreshControl: UIRefreshControl {
    
    // MARK: - Proprties
    var refreshDataCompletion: (() -> Void)?
  
    // MARK: - Initialisation
    override init() {
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    func createCustomControl(completion: (() -> Void)?) {
        refreshDataCompletion = completion
        addTarget(self, action: #selector(refreshData), for: .valueChanged)
    }
    
    @objc func refreshData() {
        refreshDataCompletion?()
    }
    
}
