//
//  LoginResponse.swift
//  OnTheMap
//
//  Created by Julia Debecka on 08/07/2020.
//  Copyright © 2020 Julia Debecka. All rights reserved.
//

import Foundation
struct LoginResponse: Codable {
    let account: Account
    let session: Session
}

// MARK: - Account
struct Account: Codable {
    let registered: Bool
    let key: String
}

// MARK: - Session
struct Session: Codable {
    let id, expiration: String
}
