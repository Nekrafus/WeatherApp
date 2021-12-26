//
//  Error.swift
//  WeatherApp
//
//  Created by Vladimir Pulkhrov on 03.10.2021.
//

import Foundation

enum SystemError: LocalizedError {
    case `default`
    case jsonError
    case weatherInitIssue
    case noInternet
    
    // TODO: text && rename
    var errorDescription: String? {
        switch self {
        case .default:
            return "Something went wrong"
        case .jsonError:
            return "Cant display the weather. Please, write us a ticket."
        case .weatherInitIssue:
            return "Cant display the weather. Please, try again."
        case .noInternet:
            return "Please, check Internet connection"
        }
    }

}
