//
//  PostLogin.swift
//  OnTheMap
//
//  Created by Julia Debecka on 08/07/2020.
//  Copyright © 2020 Julia Debecka. All rights reserved.
//

import Foundation

// MARK: - PostLogin
struct PostLogin: Codable {
    let udacity: Udacity
}

// MARK: - Udacity
struct Udacity: Codable {
    let username, password: String
}
