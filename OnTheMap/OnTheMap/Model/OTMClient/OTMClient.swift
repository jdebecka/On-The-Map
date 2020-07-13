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
		static var sessionEnd = "/session"
		static var studentLocation = "/StudentLocation"
		static var limitParam = "?limit="
		static var orderParam = "&order=-updatedAt"
		
		case session
		case studentLocation(limit: Int)
		
		var stringValue: String {
			switch self {
				case .session:
					return Endpoint.base + Endpoint.sessionEnd
				case .studentLocation(let limit):
					return Endpoint.base + Endpoint.studentLocation + Endpoint.limitParam + "\(limit)" + Endpoint.orderParam
			}
		}
		
		var url: URL {
			return URL(string: stringValue)!
		}
	}
	
	class func getSession(for username: String, with password: String, completion: @escaping (Bool, Error?) -> Void) {
		var request = URLRequest(url: Endpoint.session.url)
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
			let decoder = JSONDecoder()
			guard let data = data else {
				completion(false, error)
				return
			}
			let newData = data.subdata(in: 5..<data.count)
			
			do {
				let _ = try decoder.decode(LoginResponse.self, from: newData)
				completion(true, nil)
			}catch {
				do {
					let errorResponse = try decoder.decode(ErrorResponse.self, from: newData)
				
					completion(false, errorResponse)
				}catch {
					print(error)
				}
			}
		}
		task.resume()
	}
	
	class func deleteSession(for username: String, with password: String, completion: @escaping (Bool, Error?) -> Void) {
		var request = URLRequest(url: Endpoint.session.url)
		request.httpMethod = "DELETE"
		request.addValue("application/json", forHTTPHeaderField: "Accept")
		request.addValue("application/json", forHTTPHeaderField: "Content-Type")
		
		var xsrfCookie: HTTPCookie? = nil
		let sharedCookieStorage = HTTPCookieStorage.shared
		for cookie in sharedCookieStorage.cookies! {
		  if cookie.name == "XSRF-TOKEN" { xsrfCookie = cookie }
		}
		if let xsrfCookie = xsrfCookie {
		  request.setValue(xsrfCookie.value, forHTTPHeaderField: "X-XSRF-TOKEN")
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
	
	class func getPostedLocation(with limit: Int, completion: @escaping (PostedLocation?, Error?) -> Void) {
		var request = URLRequest(url: Endpoint.studentLocation(limit: limit).url)
		request.httpMethod = "GET"
		
		let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
			guard let data = data else {
				completion(nil, error)
				return
			}
			
			let decoder = JSONDecoder()
			
			do {
				let objectResult = try decoder.decode(PostedLocation.self, from: data)
				completion(objectResult, nil)
			}catch {
				print(error.localizedDescription)
			}
			
		}
		task.resume()
	}
}
