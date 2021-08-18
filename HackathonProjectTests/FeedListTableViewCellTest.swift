//
//  FeedListTableViewCellTest.swift
//  HackathonProjectTests
//
//  Created by Swati Yadav on 17/08/21.
//

import XCTest
@testable import HackathonProject

class FeedListTableViewCellTest: XCTestCase {

    private var sut = FeedListTableViewCell()

    func testSetSelected() {
        XCTAssertNotNil(sut.setSelected(true, animated: false))
    }
}
