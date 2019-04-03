//
//  ViewPostingsViewController.swift
//  Booked
//
//  Created by Alex Urbanski on 4/3/19.
//  Copyright © 2019 Alex Urbanski. All rights reserved.
//

import UIKit
import Firebase

class ViewPostingsViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    var postingsArray: [Posting] = [Posting]()
    
    @IBOutlet weak var postingsCollectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        postingsCollectionView.delegate = self
        postingsCollectionView.dataSource = self
        
        postingsCollectionView.register(UINib.init(nibName: "TextbookTableViewCell", bundle: nil), forCellWithReuseIdentifier: "TextbookTableViewCell")
        
        getPostings()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TextbookTableViewCell", for: indexPath) as! TextbookTableViewCell
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
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
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
            self.postingsCollectionView.reloadData()
        }
    }
}
