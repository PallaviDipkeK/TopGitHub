//
//  TestViewModel.swift
//  TopGitHubTests
//
//  Created by Pallavi Anant Dipke on 31/10/21.
//

import XCTest
@testable import TopGitHub

class TestViewModel: XCTestCase {
    var viewModel: GithubRepoListViewModel?
    
    override func setUp() {
        super.setUp()
    }
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        viewModel?.setDefaultData()
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    
    // MARK: - UI CHECK TEST
    func testViewModelDefaultData() {
        viewModel?.setDefaultData()
        XCTAssertNil(viewModel?.filterByTime != "", "filterByTime is nil")
    }
    
    // MARK: - API CHECK TEST
    
    func testLanguageData() {
        let expection = self.expectation(description: "Data is not nil")
        viewModel?.getLanguagesList()
        XCTAssertNotNil(viewModel?.languageModel?.count ?? 0 > 0)
        waitForExpectations(timeout: 5) { (error) in
            if (error != nil){
                XCTAssert(false, "Api failed with error")
            }
        }
    }
    
}
