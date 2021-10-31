//
//  TestGitHubListViewController.swift
//  TopGitHub
//
//  Created by Pallavi Anant Dipke on 31/10/21.
//

import XCTest
@testable import TopGitHub

class TestGitHubListViewController: XCTestCase {
    var listViewController: GitHubListViewController?
    
    override func setUp() {
        super.setUp()
    }
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        configureViewController()
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    
    // MARK: - UI CHECK TEST
     func configureViewController() {
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        listViewController = mainStoryboard.instantiateViewController(withIdentifier: "GitHubListViewController") as? GitHubListViewController
        listViewController?.loadViewIfNeeded()
    }
    
     func testTableView() {
        listViewController = GitHubListViewController.instantiate()
        if listViewController?.repoTableView != nil{
            XCTAssertNotNil(listViewController, "repoTableView does not exist")
        }
    }
    
     func testViewControllerExists() {
        XCTAssertNotNil(listViewController, "GitHubListViewController does not exist")
    }
    
     func testTableViewOutletAdded() {
        let tableView: UITableView? = listViewController?.repoTableView
        XCTAssertNotNil(tableView, "Table not initialized")
    }
    
    // MARK: - API CHECK TEST
    
    func testParsingifAPIResponse() {
        let expection = self.expectation(description: "Data is not nil")
        listViewController?.viewModel.callListApi(completionHandler: { (status, message) in
            if status {
                XCTAssertNotNil(self.listViewController?.viewModel.languageModel)
                XCTAssertGreaterThan(self.listViewController?.viewModel.languageModel?.count ?? 0, 0)
                expection.fulfill()
            }
        })
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    private func testRepoDatafromAPI() {
        let moviesExpectation = expectation(description: "Status Ok")
        listViewController?.viewModel.callListApi(completionHandler: { (status, message) in
            if (self.listViewController?.viewModel.languageModel?.count  ?? 0) > 0 {
                moviesExpectation.fulfill()
            }
        })
        waitForExpectations(timeout: 2) { (error) in
            if (error != nil){
                XCTAssert(false, "Api failed with error")
            }
            
        }
    }
    
}
