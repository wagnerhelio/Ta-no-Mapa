//
//  CreateLocationViewController.swift
//  Ta no Mapa
//
//  Created by Wagner  Filho on 27/09/2018.
//  Copyright © 2018 Artesmix. All rights reserved.
//
import Foundation
import UIKit
import CoreLocation

class CreateLocationViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var tfLocation: UITextField!
    @IBOutlet var tfURL: UITextField!
    @IBOutlet var btnFind: UIButton!
    @IBOutlet var btnCancel: UIBarButtonItem!
    
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    var geocoder = CLGeocoder()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tfLocation.delegate = self
        tfURL.delegate = self
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func displayError(_ error: String) {
        let alert = UIAlertController(title: "Error", message: error, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: .default))
        self.present(alert, animated: true, completion: nil)
    }

    @IBAction func btnCancel(_ sender: Any) {
    dismiss(animated: true, completion: nil)
    }

    @IBAction func btnFind(_ sender: Any) {
        
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        
        let location = tfLocation.text!
        let Url = tfURL.text!
        if location.isEmpty || Url.isEmpty {
            self.displayError("Location or Website Empty.")
        } else {
            geocoder.geocodeAddressString(tfLocation.text!) {
                (placemarks, error) in
                if error != nil {
               
                    self.displayError("Location Not Found")
                    return
                }
                
                if let placemark = placemarks?[0] {
                    performUIUpdatesOnMain {
                        let location = placemark.location!
                        let mapVC = self.storyboard?.instantiateViewController(withIdentifier: "SaveLocationMapViewController") as! SaveLocationMapViewController
                        
                        let student = UdacityStudentInformation()
                        student.FirstName = UdacityConstants.ParameterValues.Email
                        student.MapString = self.tfLocation.text!
                        student.MediaURL = self.tfURL.text!
                        student.Latitude = location.coordinate.latitude
                        student.Longitude = location.coordinate.longitude
                        
                        mapVC.student = student
                        
                        self.activityIndicator.stopAnimating()
                        self.navigationController?.pushViewController(mapVC, animated: true)
                    }
                }
            }
        }
        
    }
    
}
