//
//  ButtonExtension.swift
//  OnTheMap
//
//  Created by Julia Debecka on 08/07/2020.
//  Copyright © 2020 Julia Debecka. All rights reserved.
//

import UIKit

@IBDesignable
extension UIButton {
	@IBInspectable
	var cornerRadious: CGFloat {
		get {
			return layer.cornerRadius
		}
		set {
			layer.cornerRadius = newValue
			layer.masksToBounds = newValue > 0
		}
	}
}
