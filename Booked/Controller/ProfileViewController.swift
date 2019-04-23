//
//  ProfileViewController.swift
//  Booked
//
//  Created by Allison MacMillan on 4/22/19.
//  Copyright © 2019 Alex Urbanski. All rights reserved.
//

import UIKit
import FirebaseAuth

class ProfileViewController: UIViewController {
    @IBOutlet weak var postingsCollectionView: UICollectionView!
    
    @IBOutlet weak var userEmail: UILabel!
    
    override func viewDidLoad() {
        retrieveUser()
    }
    
    func retrieveUser() {
        self.userEmail.text = Auth.auth().currentUser?.email!
    }
}
