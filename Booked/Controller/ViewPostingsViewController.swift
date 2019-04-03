//
//  ViewPostingsViewController.swift
//  Booked
//
//  Created by Alex Urbanski on 4/3/19.
//  Copyright © 2019 Alex Urbanski. All rights reserved.
//

import UIKit
import Firebase

class ViewPostingsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var postingsArray: [Posting] = [Posting]()
    
    @IBOutlet weak var postingsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        postingsTableView.delegate = self
        postingsTableView.dataSource = self
        
        postingsTableView.register(UINib(nibName: "TextbookTableViewCell", bundle: nil), forCellReuseIdentifier: "TextbookTableViewCell")
        postingsTableView.separatorStyle = .none
        
        getPostings()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TextbookTableViewCell", for: indexPath) as! TextbookTableViewCell
        cell.posting = postingsArray[indexPath.row]
        cell.priceTextField.text = postingsArray[indexPath.row].price
        let imageReference = Storage.storage().reference(forURL: postingsArray[indexPath.row].imageURL)
        
        imageReference.getData(maxSize: 1 * 1024 * 1024) { data, error in
            if let error = error {
                print(error)
            } else {
                cell.bookImageView.image = UIImage(data: data!)
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postingsArray.count
    }
    
    func populatePosting(posting: Posting, snapshot: Dictionary<String, String>) -> Posting {
        
        posting.title = snapshot["Title"]!
        posting.author = snapshot["Author"]!
        posting.isbn = snapshot["ISBN"]!
        posting.price = snapshot["Price"]!
        posting.condition = snapshot["Condition"]!
        posting.seller = snapshot["Seller"]!
        posting.imageURL = snapshot["ImageURL"]!
        
        return posting
    }
    
    func getPostings() {
        let postingsDB = Database.database().reference().child("Postings")
        postingsDB.observe(.childAdded) { (snapshot) in
            let snapshotValue = snapshot.value as! Dictionary<String, String>
            let posting = self.populatePosting(posting: Posting(), snapshot: snapshotValue)
            
            self.postingsArray.append(posting)
            self.postingsTableView.reloadData()
        }
    }
}
