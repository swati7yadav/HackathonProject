//
//  FeedServiceTest.swift
//  HackathonProjectTests
//
//  Created by Swati Yadav on 19/08/21.
//

import XCTest
@testable import HackathonProject

class FeedServiceTest: XCTestCase {

    func testFetchFeedList() {
        let expectation = XCTestExpectation(description: "expectation")
        FeedListService.shared.fetchFeedList(afterLink: "", completion: { (_) in
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 5.0)
    }
}
