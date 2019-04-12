//
//  BillingViewController.swift
//  Booked
//
//  Created by Alex Urbanski on 4/12/19.
//  Copyright © 2019 Alex Urbanski. All rights reserved.
//

import UIKit

class BillingViewController: UIViewController {
    
    var myPageViewController: CheckoutPageViewController?

    override func viewDidLoad() {
        super.viewDidLoad()
        myPageViewController = self.parent as! CheckoutPageViewController

        // Do any additional setup after loading the view.
    }
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var streetAddressTextField: UITextField!
    @IBOutlet weak var stateTextField: UITextField!
    @IBOutlet weak var zipTextField: UITextField!
    @IBOutlet weak var cityTextField: UITextField!
    
    func populateAddress(_ address: Address) {
        address.billingName = nameTextField.text!
        address.billingAddress = streetAddressTextField.text!
        address.billingState = stateTextField.text!
        address.billingZip = zipTextField.text!
        address.billingCity = cityTextField.text!
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func continueButtonPressed(_ sender: Any) {
        let address = Address()
        populateAddress(address)
        address.markShippingSame()
        myPageViewController?.address = address
        myPageViewController?.nextPage()
    }
    
}
