//
//  APIErrors.swift
//  Gangireddi
//
//  Created by Apple on 30/01/22.
//

import Foundation

enum APIError: Error {
    case invalidURL
    case unableToComplete
    case invalidResponse
    case invalidData
}
