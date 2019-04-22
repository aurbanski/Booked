//
//  CartViewController.swift
//  Booked
//
//  Created by Alex Urbanski on 4/5/19.
//  Copyright © 2019 Alex Urbanski. All rights reserved.
//

import UIKit
import Firebase

class CartViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var totalCost: Int = 0
    var myPageViewController: CheckoutPageViewController?
    var cartArray: [Posting] = [Posting]()
    @IBOutlet weak var cartTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        cartTableView.delegate = self
        cartTableView.dataSource = self
        
        cartTableView.register(UINib(nibName: "CartTableViewCell", bundle: nil), forCellReuseIdentifier: "CartTableViewCell")
        
        configureTableView()
        retrievePostings()
        cartTableView.separatorStyle = .none
        myPageViewController = self.parent as! CheckoutPageViewController
        totalCost = 0
    }
    
    func configureTableView() {
        cartTableView.rowHeight = 150.0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            totalCost = 0
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CartTableViewCell", for: indexPath) as! CartTableViewCell
        
        var price = cartArray[indexPath.row].price
        price.remove(at: price.startIndex)
        totalCost += Int(price)!
        cell.titleLabel.text = cartArray[indexPath.row].title
        cell.authorLabel.text = cartArray[indexPath.row].author
        cell.priceLabel.text = cartArray[indexPath.row].price
        let imageReference = Storage.storage().reference(forURL: cartArray[indexPath.row].imageURL)
        
        imageReference.getData(maxSize: 1 * 1024 * 1024) { data, error in
            if let error = error {
                print(error)
            } else {
                cell.textbookImageView.image = UIImage(data: data!)
            }
        }
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cartArray.count
    }
    
    func populatePosting(posting: Posting, snapshot: Dictionary<String, String>) -> Posting {
        
        posting.uid = snapshot["UID"]!
        posting.title = snapshot["Title"]!
        posting.author = snapshot["Author"]!
        posting.isbn = snapshot["ISBN"]!
        posting.price = snapshot["Price"]!
        posting.condition = snapshot["Condition"]!
        posting.seller = snapshot["Seller"]!
        posting.imageURL = snapshot["ImageURL"]!
        
        return posting
    }
    
    func purchaseToast() {
        self.view.makeToast("Transaction Complete", duration: 3.0, position: .top)
    }
    
    func deleteAllPostings() {
        self.cartArray = []
        self.cartTableView.reloadData()
        self.configureTableView()
    }
    
    func retrievePostings() {
        Database.database().reference().child("Carts").queryOrdered(byChild: "userID").queryEqual(toValue: Auth.auth().currentUser?.uid).observeSingleEvent(of: .childAdded) { (snapshot) in
            snapshot.ref.child("Postings").observe(.childAdded, with: { (innerSnapshot) in
                Database.database().reference().child("Postings/\(innerSnapshot.key)").observeSingleEvent(of: .value, with: { (postingSnapshot) in
                    let snapshotValue = postingSnapshot.value as! Dictionary<String, String>
                    let posting = self.populatePosting(posting: Posting(), snapshot: snapshotValue)
                    
                    self.cartArray.append(posting)
                    self.cartTableView.reloadData()
                })

                self.configureTableView()
            })
        }
    }
    
    @IBAction func continueButtonPressed(_ sender: Any) {
        myPageViewController?.totalCost = totalCost
        myPageViewController?.nextPage()
    }
}
