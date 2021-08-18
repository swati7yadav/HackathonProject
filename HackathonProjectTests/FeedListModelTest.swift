//
//  FeedListModelTest.swift
//  HackathonProjectTests
//
//  Created by Swati Yadav on 19/08/21.
//

import XCTest
@testable import HackathonProject

class FeedListModelTest: XCTestCase, Parseable {

    func testParseEmptyFeedListModel() {
        // giving empty data
        let data = Data()

        // giving completion after parsing
        // expected valid feed data
        let completion: ((Result<FeedListModel, ErrorResult>) -> Void) = { result in
            switch result {
            case .success(_):
                XCTAssert(false, "Expected failure when no data")
            default:
                break
            }
        }
        parse(FeedListModel.self, from: data, completion: completion)
    }
    
    func testParseFeedListModel() {
        // giving a sample json file
        guard let data = FileManager.readJson(forResource: "feed") else {
            XCTAssert(false, "Can't get data from feed.json")
            return
        }
        
        // giving completion after parsing
        // expected valid model with valid data
        let completion: ((Result<FeedListModel, ErrorResult>) -> Void) = { result in
            switch result {
            case .failure(_):
                XCTAssert(false, "Expected valid model")
            case .success(let model):
                
                XCTAssertNotNil(model)
            }
        }
        
        parse(FeedListModel.self, from: data, completion: completion)
    }
}
