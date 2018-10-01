//
//  MapViewController.swift
//  Ta no Mapa
//
//  Created by Wagner  Filho on 27/09/2018.
//  Copyright © 2018 Artesmix. All rights reserved.
//

import UIKit
import Foundation
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate {

    @IBOutlet var mapView: MKMapView!
    @IBOutlet var btnAdd: UIBarButtonItem!
    @IBOutlet var btnReload: UIBarButtonItem!
    @IBOutlet var btnLogout: UIBarButtonItem!
    
    var studentModel : UdacityStudentModel {
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        return appDelegate.studentModel
    }
    
    let  networkManager = UdacityNetworkFunctions()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
    }
    override func viewWillAppear(_ animated: Bool) {
        createAnnotations()
    }
    
    
    func createAnnotations() {
        let students = studentModel.Students
        var annotations = [MKPointAnnotation]()
        for student in students {
            
            if let latitude = student.Latitude, let longitude = student.Longitude, let firstName = student.FirstName, let lastName = student.LastName, let mediaURL = student.MediaURL {
                // This is a version of the Double type.
                let lat = CLLocationDegrees(latitude)
                let long = CLLocationDegrees(longitude)
                
                // The lat and long are used to create a CLLocationCoordinates2D instance.
                let coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
                
                // Here we create the annotation and set its coordiate, title, and subtitle properties
                let annotation = MKPointAnnotation()
                annotation.coordinate = coordinate
                annotation.title = "\(firstName) \(lastName)"
                annotation.subtitle = mediaURL
                
                // Finally we place the annotation in an array of annotations.
                annotations.append(annotation)
            }
        }
        // When the array is complete, we add the annotations to the map.
        self.mapView.addAnnotations(annotations)
    }
    
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
            let app = UIApplication.shared
            if let toOpen = view.annotation?.subtitle! {
                if let url = URL(string: toOpen) {
                    app.openURL(url)
                }
            }
        }
    }
    
    func displayError(_ error: String) {
        let alert = UIAlertController(title: "Error", message: error, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: .default))
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func btnReload(_ sender: Any) {
        studentModel.LoadStudents { (error) in
            if error != nil {
                self.displayError("Could Not Load Data")
                
            } else {
                performUIUpdatesOnMain {
                    let old = self.mapView.annotations
                    self.mapView.removeAnnotations(old)
                    self.createAnnotations()
                }
            }
        }
    }
    
    @IBAction func btnLogout(_ sender: Any) {
        networkManager.DeleteSession()
        performUIUpdatesOnMain {
            //let controller = self.storyboard!.instantiateViewController(withIdentifier: "LoginViewController")
            //self.present(controller, animated: true, completion: nil)
            self.dismiss(animated: true, completion: nil)
            

        }
    }
}
