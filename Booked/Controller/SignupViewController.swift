//
//  SignupViewController.swift
//  Booked
//
//  Created by Alex Urbanski on 3/31/19.
//  Copyright © 2019 Alex Urbanski. All rights reserved.
//

import UIKit
import Firebase

class SignupViewController: UIViewController {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func signupButtonPressed(_ sender: Any) {
        Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextField.text!) { (user, error) in
            if error != nil {
                print(error!)
            } else {
                print("Success!")
            }
        }
    }
    
}
