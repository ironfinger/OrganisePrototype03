//
//  ViewController.swift
//  OrganisePrototype03
//
//  Created by Thomas Houghton on 07/11/2017.
//  Copyright © 2017 Thomas Houghton. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    
    // MARK: - View Setup
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        setupView()
    }

    func setupView() {
        signUpButton.layer.cornerRadius = 10
        loginButton.layer.cornerRadius = 10
    }
    
    // MARK: - Actions
    @IBAction func signUpButtonTapped(_ sender: Any) {
        performSegue(withIdentifier: "signInSegue", sender: "signUp")
    }
    
    @IBAction func loginButtonTapped(_ sender: Any) {
        performSegue(withIdentifier: "signInSegue", sender: "login")
    }
    
    // MARK: - Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "signInSegue") {
            let nextVC = SignUpLoginViewController()
            nextVC.signInProcedure = sender as! String
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

