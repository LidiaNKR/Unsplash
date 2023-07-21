//
//  ServerError.swift
//  YourFavoritePhoto
//
//  Created by Лидия Ладанюк on 19.07.2023.
//

import Foundation

enum ServerError: Int, Error, LocalizedError {
    case badRequest = 400
    case unauthorized = 401
    case forbidden = 403
    case notFound = 404
    case somethingElse = 500
    case somethingElseToo = 503
    
    var errorDescription: String {
        switch self {
        case .badRequest:
            return "The request was unacceptable, often due to missing a required parameter"
        case .unauthorized:
            return "Invalid Access Token"
        case .forbidden:
            return "Missing permissions to perform request"
        case .notFound:
            return "The requested resource doesn’t exist"
        case .somethingElse, .somethingElseToo:
            return "Something went wrong on our end"
        }
    }
}
