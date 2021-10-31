//
//  BaseViewController.swift
//  TopGitHub
//
//  Created by Pallavi Anant Dipke on 28/10/21.
//

import UIKit

class BaseViewController: UIViewController, NavigationBarViewProtocol {
    
    // MARK: - IBOutlets
    @IBOutlet weak var navigationBarView: NavigationBarView!
    @IBOutlet private weak var topBarHeightConstraint: NSLayoutConstraint!
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    let greyView = UIView()
    
    // MARK: - Properties
    open var navigationBarTitle: String? {
        didSet {
            navigationBarView?.title = navigationBarTitle
        }
    }
    
    // MARK: - View life cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupOnViewLoad()
        self.navigationController?.navigationBar.isHidden = true
    }
    
    private func setupOnViewLoad() {
        navigationBarView?.updateConstraintsIfNeeded()
        setupNavigationbar()
    }
    
    open var primaryRightNavigationBarButtonType: NavigationBarButtonType? {
        didSet {
            navigationBarView?.primaryRightBarButtonType = primaryRightNavigationBarButtonType
        }
    }
    open var leftNavigationBarButtonType: NavigationBarButtonType? {
        didSet {
            navigationBarView?.leftBarButtonType = leftNavigationBarButtonType
        }
    }
    
    // MARK: - Navigation bar methods
    func setupNavigationbar() {
        navigationBarView?.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    public func setupRootViewController(navigation: UINavigationController) {
        UIApplication.shared.windows.first?.rootViewController = navigation
        UIApplication.shared.windows.first?.makeKeyAndVisible()
    }
    
    func setUpNavigationItem(title: String, subtitle: String? = nil, left: NavigationBarButtonType? = nil, primaryRight: NavigationBarButtonType? = nil) {
        navigationBarTitle = title
        navigationBarView.setTitleAlignmentToCenter()
        primaryRightNavigationBarButtonType = primaryRight
        leftNavigationBarButtonType = left
    }
    
    func navigateView(viewController: UIViewController) {
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func didTapLeftBarbutton(_ buttonType: NavigationBarButtonType?, sender: Any) {
        guard let butnType = buttonType else { return }
        switch butnType {
        default:
            navigationController?.popViewController(animated: true)
        }
    }
    
    func didTapRightBarbutton(_ buttonType: NavigationBarButtonType?, sender: Any) {
        guard let butnType = buttonType else {
            return
        }
        switch butnType {
        default:
            return
        }
    }
    
    func showToast(message : String) {
        
        let toastLabel = UILabel(frame: CGRect(x: 10, y: self.view.frame.size.height-100, width: self.view.frame.width - 20, height: 35))
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.white
        toastLabel.textAlignment = .center;
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10;
        toastLabel.clipsToBounds  =  true
        self.view.addSubview(toastLabel)
        UIView.animate(withDuration: 4.0, delay: 0.1, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }
    
    func activityIndicatorBegin() {
        activityIndicator = UIActivityIndicatorView(frame: CGRect(x: 0,y: 0,width: 50,height: 50))
        activityIndicator.color = .white
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = .large
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        self.view.isUserInteractionEnabled = false
        
        greyView.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height)
        greyView.backgroundColor = UIColor.white
        greyView.alpha = 0.5
        self.view.addSubview(greyView)
    }
    
    func activityIndicatorEnd() {
        self.activityIndicator.stopAnimating()
        self.view.isUserInteractionEnabled = true
        self.greyView.removeFromSuperview()
    }
}
