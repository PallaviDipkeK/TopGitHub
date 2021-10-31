//
//  TestDetailViewController.swift
//  TopGitHub
//
//  Created by Pallavi Anant Dipke on 31/10/21.
//


import XCTest

@testable import TopGitHub

class TestDetailViewController: XCTestCase {
    var detailViewController: RepoDetailViewController?

    override func setUp() {
        super.setUp()
    }
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        testconfigureViewController()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    // MARK: - UI Related Unit Test
     func testconfigureViewController() {
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        detailViewController = mainStoryboard.instantiateViewController(withIdentifier: "RepoDetailViewController") as? RepoDetailViewController
        detailViewController?.loadViewIfNeeded()
    }
    
    func testViewControllerExists() {
        XCTAssertNotNil(detailViewController, "RepoDetailViewController does not exist")
    }
    
}
