//
//  FeedListViewModelTest.swift
//  HackathonProjectTests
//
//  Created by Swati Yadav on 19/08/21.
//

import XCTest
@testable import HackathonProject

class FeedListViewModelTest: XCTestCase {
    
    private var sut: FeedListViewModel!
    fileprivate var service: MockFeedListService!
    
    override func setUp() {
        super.setUp()
        service = MockFeedListService()
        sut = FeedListViewModel(service: service)
    }
    
    override func tearDown() {
        sut = nil
        service = nil
        super.tearDown()
    }
    
    func testFetchWithNoService() {
        // giving no service to a view model
        sut.service = nil
        
        sut.onErrorHandling = { error in
            // expected to not be able to fetch feed
        }
        sut.getFeedListData()
    }
    
    fileprivate class MockFeedListService: FeedListServiceProtocol {
        
        var feedlistModel: FeedListModel?
        
        func fetchFeedList(afterLink: String, completion: @escaping ((Result<FeedListModel, ErrorResult>) -> Void)) {
            
            if let model = feedlistModel {
                completion(Result.success(model))
            } else {
                completion(Result.failure(ErrorResult.custom(string: "Invalid model")))
            }
        }
    }
}
