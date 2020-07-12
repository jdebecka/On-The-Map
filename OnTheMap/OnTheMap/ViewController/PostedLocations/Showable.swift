//
//  Showable.swift
//  OnTheMap
//
//  Created by Julia Debecka on 12/07/2020.
//  Copyright © 2020 Julia Debecka. All rights reserved.
//

import UIKit
protocol Showable: UIViewController {
	
	var recentLocations: PostedLocation! { get set }
	func getRecentLocation(for limit: Int)
	func handleGetStudentLocation(postedLocation: PostedLocation?, error: Error?)
}

extension Showable {
	func getRecentLocation(for limit: Int) {
		OTMClient.getPostedLocation(with: limit, completion: handleGetStudentLocation(postedLocation:error:))
	}
	
	func handleGetStudentLocation(postedLocation: PostedLocation?, error: Error?){
		if let postedData = postedLocation {
			self.recentLocations = postedData
		}
	}
}
