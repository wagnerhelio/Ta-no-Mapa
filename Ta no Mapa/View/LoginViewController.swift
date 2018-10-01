//
//  LoginViewController.swift
//  Ta no Mapa
//
//  Created by Wagner  Filho on 27/09/2018.
//  Copyright © 2018 Artesmix. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController,UITextFieldDelegate {

    @IBOutlet var UdacityImage: UIImageView!
    @IBOutlet var tfEmail: UITextField!
    @IBOutlet var tfPassword: UITextField!
    @IBOutlet var btnLogin: UIButton!
    @IBOutlet var btnSingIn: UIButton!
    
    var studentModel : UdacityStudentModel {
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        return appDelegate.studentModel
    }
    
    let  networkManager = UdacityNetworkFunctions()
    
//Override
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        tfEmail.delegate = self
        tfPassword.delegate = self
    }
//Func
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func completeLogin() {
        studentModel.LoadStudents() { (error) in
            if error != nil {
                performUIUpdatesOnMain {

                    self.displayError("Couldn't Load Student Data!")
                }
            } else {
                performUIUpdatesOnMain {
                   
                    let controller = self.storyboard!.instantiateViewController(withIdentifier: "TabBarController") as! UITabBarController
                    self.present(controller, animated: true, completion: nil)
                }
            }
        }
    }
    //Informe Error Login User
    func displayError(_ error: String) {
        let alert = UIAlertController(title: "Error", message: error, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: .default))
        self.present(alert, animated: true, completion: nil)
    }
    
    //Action
    @IBAction func btnLogin(_ sender: Any) {
        
        let email = tfEmail.text!
        let password = tfPassword.text!
        if email.isEmpty || password.isEmpty {
            
            self.displayError("Empty Email or Password.")
        } else {
            UdacityConstants.ParameterValues.Email = email
            UdacityConstants.ParameterValues.Password = password
        }
        networkManager.UdacityAuthentication {(success, error) in performUIUpdatesOnMain {
            if success {
                self.completeLogin()
            } else {
                
                self.displayError(error ?? "")
            }
            }
        }
        tfEmail.text = ""
        tfPassword.text = ""
    }
    
    @IBAction func btnSingin(_ sender: Any) {
        if let signUpURL = URL(string: UdacityClient.signUpURL), UIApplication.shared.canOpenURL(signUpURL) {
            UIApplication.shared.open(signUpURL)
        }
    }
    

}
