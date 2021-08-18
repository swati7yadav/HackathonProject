//
//  FeedListService.swift
//  HackathonProject
//
//  Created by Swati Yadav on 17/08/21.
//

import Foundation

// Feed list helper methods
protocol FeedListServiceProtocol: class {
    func fetchFeedList(afterLink: String, completion: @escaping ((Result<FeedListModel, ErrorResult>) -> Void))
}

final class FeedListService: Parseable, FeedListServiceProtocol {
    
    static let shared = FeedListService()
    
    // MARK: -  Fetch feed list data
    func fetchFeedList(afterLink: String, completion: @escaping ((Result<FeedListModel, ErrorResult>) -> Void)) {
        let endPoint = APIManager.EndPoint.FeedList(afterLink: afterLink)
        let requestData = APIManager.EndPoint.generateRequest(for: endPoint)
        
        NetworkHandler.shared.dataTask(requestObject: requestData) { (response) in
            guard let data = response?.data else {
                completion(.failure(.custom(string: response?.error.debugDescription ?? "Data not found")))
                return
            }
            self.parse(FeedListModel.self, from: data, completion: completion)
        }
    }
}
