//
//  MapViewController.swift
//  OnTheMap
//
//  Created by Julia Debecka on 12/07/2020.
//  Copyright © 2020 Julia Debecka. All rights reserved.
//

import UIKit
import MapKit
import SafariServices

class MapViewController: UIViewController, Showable {
	var recentLocations: PostedLocation!
	
	@IBOutlet weak var mapView: MKMapView!
	override func viewDidLoad() {
        super.viewDidLoad()
		getRecentLocation(for: 100)
		mapView.delegate = self

        // Do any additional setup after loading the view.
    }
	
	func handleGetStudentLocation(postedLocation: PostedLocation?, error: Error?) {
		if let postedData = postedLocation {
			recentLocations = postedData
			createPins()
		}
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		getRecentLocation(for: 100)
	}
	
	
	func createPins() {
		var annotations = [MKPointAnnotation]()
		
		for post in recentLocations.results {
			
			let lat = CLLocationDegrees(post.latitude)
			let long = CLLocationDegrees(post.longitude)
			 let coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
			let annotation = MKPointAnnotation()
			annotation.coordinate = coordinate
			annotation.title = post.firstName + post.lastName
			annotation.subtitle = post.mediaURL
			
			annotations.append(annotation)
		}
		
		self.mapView.addAnnotations(annotations)
	}

}

extension MapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        let reuseId = "pin"
        
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId) as? MKPinAnnotationView

        if pinView == nil {
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            pinView!.canShowCallout = true
			pinView!.pinTintColor = .red
            pinView!.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        }
        else {
            pinView!.annotation = annotation
        }
        
        return pinView
    }
	
	    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if control == view.rightCalloutAccessoryView {
            if let toOpen = view.annotation?.subtitle! {
				if let url = URL(string: toOpen) {
					let svc = SFSafariViewController(url: url)
					present(svc, animated: true, completion: nil)
				}
            }
        }
    }
}
