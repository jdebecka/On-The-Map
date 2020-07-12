//
//  TablePinsViewController.swift
//  OnTheMap
//
//  Created by Julia Debecka on 09/07/2020.
//  Copyright © 2020 Julia Debecka. All rights reserved.
//

import UIKit
import SafariServices

let cellId = "pinLocationCell"
class TablePinsViewController: UIViewController, Showable {
	var recentLocations: PostedLocation! = PostedLocation(results: [])
	

	@IBOutlet weak var tableView: UITableView!
	override func viewDidLoad() {
        super.viewDidLoad()
		
		tableView.dataSource = self
		tableView.delegate = self
		
		tableView.rowHeight = UITableView.automaticDimension
		tableView.estimatedRowHeight = 600
		getRecentLocation(for: 100)

        // Do any additional setup after loading the view.
    }
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
	}
	
	func handleGetStudentLocation(postedLocation: PostedLocation?, error: Error?) {
		if let postedData = postedLocation {
			self.recentLocations = postedData
			DispatchQueue.main.async {
				self.tableView.reloadData()
			}
			
		}
	}
	

}

extension TablePinsViewController : UITableViewDelegate, UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return recentLocations.results.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: cellId) as! PinLocationTableViewCell
		let cellData = recentLocations.results[indexPath.row]
		cell.nameLabel.text = cellData.firstName + cellData.lastName
		cell.linkLabel.text = cellData.mediaURL
		
		return cell
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let toOpen = recentLocations.results[indexPath.row].mediaURL
		if let url = URL(string: toOpen) {
			let svc = SFSafariViewController(url: url)
			present(svc, animated: true, completion: nil)
		}
	}
}
