//
//  OTMClient.swift
//  OnTheMap
//
//  Created by Julia Debecka on 08/07/2020.
//  Copyright © 2020 Julia Debecka. All rights reserved.
//

import Foundation

class OTMClient {
	enum Auth {
		static var sessionId = ""
	}
	
	enum Endpoint {
		static var base = "https://onthemap-api.udacity.com/v1"
		static var session = "/session"
		
		case postSession
		
		var stringValue: String {
			switch self {
				case .postSession:
					return Endpoint.base + Endpoint.session
			}
		}
		
		var url: URL {
			return URL(string: stringValue)!
		}
	}
	
	class func getSession(for username: String, with password: String, completion: @escaping (Bool, Error?) -> Void) {
		var request = URLRequest(url: Endpoint.postSession.url)
		request.httpMethod = "POST"
		request.addValue("application/json", forHTTPHeaderField: "Accept")
		request.addValue("application/json", forHTTPHeaderField: "Content-Type")
		
		let udacityUser = Udacity(username: username, password: password)
		let requestBody = PostLogin(udacity: udacityUser)
		
		do {
			let bodyData = try JSONEncoder().encode(requestBody)
			request.httpBody = bodyData
		}catch {
			completion(false, error)
			return
		}
		
		let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
			guard let data = data else {
				completion(false, error)
				return
			}
			let newData = data.subdata(in: 5..<data.count) /* subset response data! */
			print(String(data: newData, encoding: .utf8)!)
			
			completion(true, nil)
		}
		task.resume()
	}
}
