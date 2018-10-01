//
//  MapTableViewController.swift
//  Ta no Mapa
//
//  Created by Wagner  Filho on 27/09/2018.
//  Copyright © 2018 Artesmix. All rights reserved.
//
import Foundation
import UIKit

class MapTableViewController: UITableViewController {
    
    
    var studentModel : UdacityStudentModel {
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        return appDelegate.studentModel
    }
    let  networkManager = UdacityNetworkFunctions()

    override func viewDidLoad() {
        super.viewDidLoad()
          
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "Cell")as! MapTableViewCell
        let student : UdacityStudentInformation = studentModel.Students[(indexPath as NSIndexPath).row]
        cell.fullName.text = student.FirstName
        cell.mediaURL.text = student.MediaURL
        
        return cell
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return studentModel.Students.count
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        self.tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let student = studentModel.Students[(indexPath as NSIndexPath).row]
        let app = UIApplication.shared
        if let url = URL(string: student.MediaURL!) {
            app.openURL(url)
        }
    }
    
    func displayError(_ error: String) {
        let alert = UIAlertController(title: "Error", message: error, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: .default))
        self.present(alert, animated: true, completion: nil)
    }

    @IBAction func btnLogout(_ sender: Any) {
        
        networkManager.DeleteSession()
        //performUIUpdatesOnMain {
            //let controller = self.storyboard!.instantiateViewController(withIdentifier: "LoginViewController")
            //self.present(controller, animated: true, completion: nil)
            self.dismiss(animated: true, completion: nil)
        //}
    }
    
    @IBAction func btnReload(_ sender: Any) {
        studentModel.LoadStudents { (error) in
            if error != nil {
                self.displayError("Could Not Load Data")
            } else{
                performUIUpdatesOnMain {
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    
}
