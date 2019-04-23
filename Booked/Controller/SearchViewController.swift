//
//  SearchViewController.swift
//  Booked
//
//  Created by Alex Urbanski on 4/21/19.
//  Copyright © 2019 Alex Urbanski. All rights reserved.
//

import UIKit
import Firebase

class SearchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var searchArray: [Posting] = [Posting]()
    @IBOutlet weak var searchTableView: UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchTableView.delegate = self
        searchTableView.dataSource = self
        
        searchTableView.register(UINib(nibName: "SearchTableViewCell", bundle: nil), forCellReuseIdentifier: "SearchTableViewCell")
        
        configureTableView()
        searchTableView.separatorStyle = .none
        
        setupTextFieldShadow()
        // Do any additional setup after loading the view.
    }
    
    func setupTextFieldShadow()  {
        searchTextField.layer.masksToBounds = false
        searchTextField.layer.shadowRadius = 8.0
        searchTextField.layer.shadowColor = UIColor.black.cgColor
        searchTextField.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        searchTextField.layer.shadowOpacity = 0.5
    }
    
    func configureTableView() {
        searchTableView.rowHeight = 150.0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchTableViewCell", for: indexPath) as! SearchTableViewCell
        
        cell.posting = searchArray[indexPath.row]
        var price = searchArray[indexPath.row].price
        price.remove(at: price.startIndex)
        cell.titleLabel.text = searchArray[indexPath.row].title
        cell.authorLabel.text = searchArray[indexPath.row].author
        cell.priceLabel.text = searchArray[indexPath.row].price
        let imageReference = Storage.storage().reference(forURL: searchArray[indexPath.row].imageURL)
        
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
        return searchArray.count
    }
    
    @IBOutlet weak var searchTextField: TextField!
    
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
    
    func deleteAllPostings() {
        self.searchArray = []
        self.searchTableView.reloadData()
        self.configureTableView()
    }
    
    func fillArray(_ snapshotValue: Dictionary<String, String>) {
        let posting = self.populatePosting(posting: Posting(), snapshot: snapshotValue)
        self.searchArray.append(posting)
        self.searchTableView.reloadData()
    }
    
    func searchForValue(_ childName: String) {
        Database.database().reference().child("Postings").queryOrdered(byChild: childName).queryStarting(atValue: searchTextField.text!).queryEnding(atValue: "\(searchTextField.text!)\u{f8ff}").observeSingleEvent(of: .childAdded) { (snapshot) in
            let snapshotValue = snapshot.value as! Dictionary<String, String>
            self.fillArray(snapshotValue)
        }
    }
    
    func retrievePostings() {
        deleteAllPostings()
        if searchTextField.text! != "" {
            searchForValue("Title")
            searchForValue("Author")
            searchForValue("ISBN")
        }
        
        self.configureTableView()
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func searchButtonPressed(_ sender: Any) {
        retrievePostings()
    }
    
}


class TextField: UITextField {
    
    let padding = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
    
    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
}
