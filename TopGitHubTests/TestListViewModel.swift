//
//  TestListViewModel.swift
//  TopGitHubTests
//
//  Created by Pallavi Anant Dipke on 31/10/21.
//

import XCTest

@testable import TopGitHub

class TestListViewModel: XCTestCase {
    var viewModel: GithubRepoListViewModel? = GithubRepoListViewModel()
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    override func setUp() {
        super.setUp()
        viewModel?.setDefaultData()
    }
    
    // MARK: - DEFAULT DATA CHECKER
    func testViewModelDefaultData() {
        XCTAssertEqual(viewModel?.filterByLanguage, "java")
        XCTAssertEqual(viewModel?.filterByTime, "Yearly")
    }
    
    // MARK: - API CHECK TEST
    func testLanguageData() {
        let expection = self.expectation(description: "Data is not nil")
        viewModel?.getLanguagesList()
        XCTAssertNotNil(viewModel?.languageModel)
        XCTAssertGreaterThan(viewModel?.languageModel?.count ?? 0, 0)
        expection.fulfill()
        waitForExpectations(timeout: 5, handler: nil)
    }
}
