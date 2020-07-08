//
//  ViewController.swift
//  OnTheMap
//
//  Created by Julia Debecka on 08/07/2020.
//  Copyright © 2020 Julia Debecka. All rights reserved.
//

import UIKit
let toolBarId = "toolBarId"
class LogInViewController: UIViewController {
	
	@IBOutlet weak var passwordTextField: UITextField!
	@IBOutlet weak var emailTextField: UITextField!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.
	}
	
	@IBAction func signUpButtonTapped(_ sender: Any) {
	}
	@IBAction func loginTapped(_ sender: Any) {
		if let username = emailTextField.text,
			let password = passwordTextField.text {
			OTMClient.getSession(for: username, with: password, completion: handleLogin(success:error:))
		}
	}
	
	func handleLogin(success: Bool, error: Error?) {
		if success {
			DispatchQueue.main.async {
				self.pushToolBarVC()
			}
		}else {
			print(error.debugDescription)
		}
	}
	
	func pushToolBarVC() {
		let toolBarVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: toolBarId)
		
		navigationController?.pushViewController(toolBarVC, animated: true)
	}
	
}

