//
//  ErrorResponse.swift
//  OnTheMap
//
//  Created by Julia Debecka on 12/07/2020.
//  Copyright © 2020 Julia Debecka. All rights reserved.
//

import Foundation

// MARK: - ErrorResponse
struct ErrorResponse: Codable, Error {
    let status: Int
    let error: String
}
