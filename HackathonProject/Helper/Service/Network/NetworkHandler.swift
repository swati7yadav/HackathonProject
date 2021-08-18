//
//  NetworkHandler.swift
//  HackathonProject
//
//  Created by Swati Yadav on 17/08/21.
//

import Foundation

// MARK: -  Request generate model
struct RequestModel {
    let url: String?
    var httpMethod: HTTPMethod = .GET
    var headerFields: [String : String]? = nil
    var httpBody: Data? = nil
}

// MARK: -  Response model
struct ResponseModel {
    let statusCode: Int
    let error: Error?
    let data: Data?
}

// MARK: -  HTTP method type
enum HTTPMethod {
    case GET
    var value: String {
        switch self {
        case .GET:
            return "GET"
        }
    }
}

// MARK: -  NetworkHandler class
final class NetworkHandler {
    static let shared = NetworkHandler()
    typealias CompletionHandler = ((_ response: ResponseModel?) -> Void)
    
    // NetworkHandler method to send or get data
    // - Parameters:
    //   - requestObject: request object
    //   - completionHandler: response block
    func dataTask(requestObject: RequestModel, completionHandler:@escaping CompletionHandler) {
        guard let stringURL = requestObject.url,let serverURL = URL(string: stringURL) else {
            return
        }
        
        var urlRequest = URLRequest(url: serverURL)
        urlRequest.httpMethod = requestObject.httpMethod.value
        urlRequest.httpBody = requestObject.httpBody
        urlRequest.allHTTPHeaderFields = requestObject.headerFields
        //dump(urlRequest)
        
        let session = URLSession.shared
        let task = session.dataTask(with: urlRequest, completionHandler: {
            (data,response,error) in
            if let responseObject = response as? HTTPURLResponse {
                let responseModel = ResponseModel(statusCode: responseObject.statusCode, error: error, data: data)
                completionHandler(responseModel)
                return
            }
            completionHandler(nil)
        })
        task.resume()
    }
}
