//
//  SignUpLoginViewController.swift
//  OrganisePrototype03
//
//  Created by Thomas Houghton on 15/11/2017.
//  Copyright © 2017 Thomas Houghton. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class SignUpLoginViewController: UIViewController {

    @IBOutlet weak var signUpLoginLabel: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginSignUpButton: UIButton!
    @IBOutlet weak var subView: UIView!
    
    var signInProgress = 0 // This controls the progess of how far the user has got through the signUp Process
    
    // MARK: - View Setup
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // Make every alpha 0 then fade to 1
        self.view.backgroundColor = UIColor.clear
        emailTextField.alpha = 0
        passwordTextField.alpha = 0
        loginSignUpButton.alpha = 0
        subView.alpha = 0
    }
    
    override func viewDidAppear(_ animated: Bool) {
        viewSetup()
    }
    
    func viewSetup() {
        loginSignUpButton.setTitleColor(UIColor.gray, for: .normal)
        UIView.animate(withDuration: 0.5, delay: 0, options: .allowUserInteraction, animations: {
            self.view.backgroundColor = UIColor.init(red: 16/255, green: 156/255, blue: 146/255, alpha: 1)
            self.subView.alpha = 1
        }) { (true) in
            UIView.animate(withDuration: 0.5, delay: 0, options: .allowUserInteraction, animations: {
                self.emailTextField.alpha = 1
            }, completion: { (true) in
                UIView.animate(withDuration: 0.5, delay: 0, options: .allowUserInteraction, animations: {
                    self.passwordTextField.alpha = 1
                }, completion: { (true) in
                    UIView.animate(withDuration: 0.5, delay: 0, options: .allowUserInteraction, animations: {
                        self.loginSignUpButton.alpha = 0.5
                        self.loginSignUpButton.backgroundColor = UIColor.darkGray
                    }, completion: { (true) in
                        UIView.animate(withDuration: 1.5, delay: 0, options: .allowUserInteraction, animations: {
                            self.emailTextField.layer.cornerRadius = 10
                            self.passwordTextField.layer.cornerRadius = 10
                            self.loginSignUpButton.layer.cornerRadius = 10
                            self.subView.layer.cornerRadius = 15
                        }, completion: { (true) in
                            print("Animation Complete")
                        })
                    })
                })
            })
        }
    }

    // Mark: - Sign Up
    func signUp() {
        Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextField.text!) { (user, error) in
            if (error != nil) {
                print("Couldn't create user \(String(describing: error))")
            }else{
                Database.database().reference().child("Users").child(user!.uid).child("Email").setValue(self.emailTextField.text!)
                self.performSegue(withIdentifier: "mainAppSegue", sender: nil)
            }
        }
    }
    
    // Mark: - Login
    func login() {
        Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!) { (user, error) in
            if (error != nil) {
                print("We couldn't log in \(String(describing: error))")
            }else{
                print("Logged in!")
                self.performSegue(withIdentifier: "mainAppSegue", sender: nil)
            }
        }
    }
    
    // MARK: - Sign In Progress.
    func signInProgressCheck() {
        if (signInProgress == 0) {
            signInProgress = 1
            phase01Anim()
        }else if (signInProgress == 1) {
            signInProgress = 2
            phase02Anim()
            print("Sign In should be done")
        }
    }
    
    func phase01Anim() {
        UIView.animate(withDuration: 1) {
            self.loginSignUpButton.backgroundColor = UIColor.gray
            self.loginSignUpButton.setTitleColor(UIColor.white, for: .normal)
            self.loginSignUpButton.alpha = 0.8
        }
    }
    
    func phase02Anim() {
        UIView.animate(withDuration: 1) {
            self.loginSignUpButton.backgroundColor = UIColor.white
            self.loginSignUpButton.alpha = 1
            self.loginSignUpButton.setTitleColor(UIColor.init(red: 145/255, green: 253/255, blue: 220/255, alpha: 1), for: .normal)
        }
    }
    
    // Mark: - Actions
    @IBAction func emailTextFieldEdited(_ sender: Any) {
        print("Changed")
        signInProgressCheck()
    }
    
    @IBAction func passwordTextFieldEdited(_ sender: Any) {
        print("Changed")
        signInProgressCheck()
    }
    
    @IBAction func loginButtonTapped(_ sender: Any) {
        login()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
