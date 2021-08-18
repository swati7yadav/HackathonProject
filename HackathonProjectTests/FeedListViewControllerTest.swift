//
//  FeedListViewControllerTest.swift
//  HackathonProjectTests
//
//  Created by Swati Yadav on 17/08/21.
//

import XCTest
@testable import HackathonProject

class FeedListViewControllerTest: XCTestCase {

    private var sut: FeedListViewController!
    private var tableView: UITableView!
    private var feedListModel: FeedListViewModel!
    
    override func setUp() {
        tableView = UITableView(frame: CGRect(x: 0, y: 0, width: 200, height: 400), style: .plain)
        sut = FeedListViewController()
        sut.feedTableView = tableView
        sut.viewModel = FeedListViewModel()
        super.setUp()
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func testTableViewReload() {
        XCTAssertNotNil(sut.tableViewReload())
    }
    
    func testCellForRow() {
        sut.feedTableView.register(FeedListTableViewCell.self, forCellReuseIdentifier: AppConstants.feedListTableViewIdentifier)
        let cell = sut.tableView(tableView, cellForRowAt: IndexPath(row: 0, section: 0)) as? FeedListTableViewCell
        XCTAssertNil(cell)
    }
    
    func testWillDisplay() {
        XCTAssertNotNil(sut.tableView(tableView, willDisplay: UITableViewCell(), forRowAt: IndexPath(row: 0, section: 0)))
    }
}
