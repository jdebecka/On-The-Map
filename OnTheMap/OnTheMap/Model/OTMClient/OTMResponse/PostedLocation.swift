//
//  PostedLocation.swift
//  OnTheMap
//
//  Created by Julia Debecka on 12/07/2020.
//  Copyright © 2020 Julia Debecka. All rights reserved.
//

import Foundation

// MARK: - PostedLocation
struct PostedLocation: Codable {
    let results: [Result]
}

// MARK: - Result
struct Result: Codable {
    let createdAt, firstName, lastName: String
    let latitude, longitude: Double
    let mapString: String
    let mediaURL: String
    let objectID, uniqueKey, updatedAt: String

    enum CodingKeys: String, CodingKey {
        case createdAt, firstName, lastName, latitude, longitude, mapString, mediaURL
        case objectID = "objectId"
        case uniqueKey, updatedAt
    }
}
