//
//  CreditCardViewController.swift
//  Booked
//
//  Created by Alex Urbanski on 4/12/19.
//  Copyright © 2019 Alex Urbanski. All rights reserved.
//

import UIKit
import Firebase

class CreditCardViewController: UIViewController {
    
    var myPageViewController: CheckoutPageViewController?

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var cardNumberTextField: UITextField!
    @IBOutlet weak var expDateTextField: UITextField!
    @IBOutlet weak var cvvTextField: UITextField!
    @IBOutlet weak var bookCostLabel: UILabel!
    @IBOutlet weak var totalCostLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        myPageViewController = self.parent as! CheckoutPageViewController
        bookCostLabel.text = "$\((myPageViewController?.totalCost)!).00"
        totalCostLabel.text = "$\(Float(Float((myPageViewController?.totalCost)!) + 5.99).rounded(toPlaces: 2))"
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    func clearCart() {
        Database.database().reference().child("Carts").queryOrdered(byChild: "userID").queryEqual(toValue: Auth.auth().currentUser?.uid).observeSingleEvent(of: .childAdded) { (snapshot) in
            snapshot.ref.child("Postings")
            snapshot.ref.child("Postings").observe(.childAdded, with: { (innerSnapshot) in
                Database.database().reference().child("Postings").child(innerSnapshot.key).removeValue()
            })
            Database.database().reference().child("Carts").child(snapshot.key).child("Postings").removeValue()
        }
    }
    
    @IBAction func placeOrderButtonPressed(_ sender: Any) {
        let creditCard = CreditCard()
        creditCard.name = nameTextField.text!
        creditCard.cardNumber = cardNumberTextField.text!
        creditCard.expirationDate = expDateTextField.text!
        creditCard.cvv = cvvTextField.text!
        
        let transactionService = TransactionService()
        let result = transactionService.attemptPurchase(cost: (myPageViewController?.totalCost)!, address: (myPageViewController?.address)!, creditCard: creditCard)
        
        if result > 0 {
            clearCart()
            myPageViewController?.goToFirstPage()
        } else {
            self.view.makeToast("Something went wrong. Make sure you filled out all of the information", duration: 3.0, position: .top)
        }
        
    }
    
}

extension Float {
    /// Rounds the double to decimal places value
    func rounded(toPlaces places:Int) -> Float {
        let divisor = pow(10.0, Float(places))
        return (self * divisor).rounded() / divisor
    }
}
