//
//  APIManager.swift
//  HackathonProject
//
//  Created by Swati Yadav on 17/08/21.
//

import Foundation

struct APIManager {
    // API base url
    static private var baseURL: String {
        return "http://www.reddit.com/.json"
    }
    
    // MARK: - Generate endpoint for request
    enum EndPoint {
        // Get a list of feeds
        case FeedList(afterLink: String?)
        // Generate request data based on request endpoint
        // - Parameter endPoint: endpoint
        // - Returns: Request model
                
        static func generateRequest(for endPoint: EndPoint) -> RequestModel {
            var requestURL = APIManager.baseURL
            switch endPoint {
            case .FeedList(let afterLink):
                if let after = afterLink, !after.isEmpty {
                    requestURL.append("?after=\(after)")
                }
                let request = RequestModel(url: requestURL)
                return request
            }
        }
    }
}
