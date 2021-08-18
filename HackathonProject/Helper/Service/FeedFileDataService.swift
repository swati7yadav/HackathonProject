//
//  FeedFileDataService.swift
//  HackathonProject
//
//  Created by Swati Yadav on 19/08/21.
//

import Foundation

final class FeedFileDataService: FeedListServiceProtocol, Parseable {
    
    static let shared = FeedFileDataService()
    
    func fetchFeedList(afterLink: String, completion: @escaping ((Result<FeedListModel, ErrorResult>) -> Void)) {
        
        // giving a sample json file
        guard let data = FileManager.readJson(forResource: AppConstants.feedJson) else {
            completion(Result.failure(ErrorResult.custom(string: "No file or data")))
            return
        }
        parse(FeedListModel.self, from: data, completion: completion)
    }
}

extension FileManager {
    
    static func readJson(forResource fileName: String ) -> Data? {
        
        let bundle = Bundle(for: FeedFileDataService.self)
        if let path = bundle.path(forResource: fileName, ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                return data
            } catch {
                // handle error
            }
        }
        return nil
    }
}
