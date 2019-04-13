//
//  ShippingViewController.swift
//  Booked
//
//  Created by Alex Urbanski on 4/12/19.
//  Copyright © 2019 Alex Urbanski. All rights reserved.
//

import UIKit

class ShippingViewController: UIViewController {
    
    var myPageViewController: CheckoutPageViewController?
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var streetAddressTextField: UITextField!
    @IBOutlet weak var stateTextField: UITextField!
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var zipTextField: UITextField!
    @IBOutlet weak var autoFillSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        myPageViewController = self.parent as! CheckoutPageViewController
        autoFillFields()
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    func autoFillFields() {
        let billingAddress = myPageViewController?.address!
        nameTextField.text = billingAddress?.billingName
        streetAddressTextField.text = billingAddress?.billingAddress
        stateTextField.text = billingAddress?.billingState
        cityTextField.text = billingAddress?.billingCity
        zipTextField.text = billingAddress?.billingZip
    }
    
    func clearFields() {
        nameTextField.text = ""
        streetAddressTextField.text = ""
        stateTextField.text = ""
        cityTextField.text = ""
        zipTextField.text = ""
    }
    
    func populateAddress(_ address: Address) {
        address.shippingName = nameTextField.text!
        address.shippingAddress = streetAddressTextField.text!
        address.shippingState = stateTextField.text!
        address.shippingZip = zipTextField.text!
        address.shippingCity = cityTextField.text!
    }
    
    func enableTextFields() {
        nameTextField.isEnabled = true
        streetAddressTextField.isEnabled = true
        stateTextField.isEnabled = true
        cityTextField.isEnabled = true
        zipTextField.isEnabled = true
    }
    
    func disableTextFields() {
        nameTextField.isEnabled = false
        streetAddressTextField.isEnabled = false
        stateTextField.isEnabled = false
        cityTextField.isEnabled = false
        zipTextField.isEnabled = false
    }

    @IBAction func sameSwitchPressed(_ sender: Any) {
        if autoFillSwitch.isOn {
            myPageViewController?.address?.markShippingSame()
            autoFillFields()
            disableTextFields()
        } else {
            myPageViewController?.address?.clearShippingInfo()
            clearFields()
            enableTextFields()
        }
    }
    
    @IBAction func continueButtonPressed(_ sender: Any) {
        myPageViewController = self.parent as! CheckoutPageViewController
        let fullAddress = myPageViewController?.address!
        fullAddress?.billingName = nameTextField.text!
        fullAddress?.billingAddress = streetAddressTextField.text!
        fullAddress?.billingState = stateTextField.text!
        fullAddress?.billingCity = cityTextField.text!
        fullAddress?.billingZip = zipTextField.text!
        myPageViewController?.address = fullAddress
        myPageViewController?.nextPage()
    }
}
