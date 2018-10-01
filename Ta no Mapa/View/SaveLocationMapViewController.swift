//
//  SaveLocationMapViewController.swift
//  Ta no Mapa
//
//  Created by Wagner  Filho on 27/09/2018.
//  Copyright © 2018 Artesmix. All rights reserved.
//
import Foundation
import UIKit
import MapKit

class SaveLocationMapViewController: UIViewController, MKMapViewDelegate {

    @IBOutlet var mapView: MKMapView!
    
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
    var student:UdacityStudentInformation?
    
    let  networkManager = UdacityNetworkFunctions()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //Setting Region
        let center = CLLocationCoordinate2D(latitude: (student?.Latitude)!, longitude: (student?.Longitude)!)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        
        self.mapView.setRegion(region, animated: true)
        
        //Adding Pin
        let pinLocation : CLLocationCoordinate2D = CLLocationCoordinate2DMake((student?.Latitude)!, (student?.Longitude)!)
        let objectAnnotation = MKPointAnnotation()
        objectAnnotation.coordinate = pinLocation
        objectAnnotation.title = "My Location"
        self.mapView.addAnnotation(objectAnnotation)
    }
    
    func displayError(_ error: String) {
        let alert = UIAlertController(title: "Error", message: error, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: .default))
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func btnFinish(_ sender: Any) {
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        view.addSubview(activityIndicator)
        
        activityIndicator.startAnimating()
        networkManager.PostNewStudentLocation(student:student!) { (success, error) in
            performUIUpdatesOnMain {
                self.activityIndicator.stopAnimating()
            }
            
            if success{
                let tabController = self.storyboard?.instantiateViewController(withIdentifier: "TabBarController")
                self.present(tabController!, animated: true)
            } else{
                performUIUpdatesOnMain {
                    self.displayError("Could Not Add New Student.")
                }
            }
        }
    }
    
    
}
