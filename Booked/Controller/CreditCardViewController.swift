//
//  CreditCardViewController.swift
//  Booked
//
//  Created by Alex Urbanski on 4/12/19.
//  Copyright © 2019 Alex Urbanski. All rights reserved.
//

import UIKit

class CreditCardViewController: UIViewController {
    
    var myPageViewController: CheckoutPageViewController?

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var cardNumberTextField: UITextField!
    @IBOutlet weak var expDateTextField: UITextField!
    @IBOutlet weak var cvvTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        myPageViewController = self.parent as! CheckoutPageViewController
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func placeOrderButtonPressed(_ sender: Any) {
        
        //        TODO: Set this up with the mock 
    }
    
}
