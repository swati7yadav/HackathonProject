//
//  ErrorResult.swift
//  HackathonProject
//
//  Created by Swati Yadav on 17/08/21.
//

import Foundation

enum ErrorResult: Error {
    case network(string: String)
    case parser(string: String)
    case custom(string: String)
}

enum Result<T, E: Error> {
    case success(T)
    case failure(E)
}
