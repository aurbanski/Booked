//
//  SearchTableViewCell.swift
//  Booked
//
//  Created by Alex Urbanski on 4/21/19.
//  Copyright © 2019 Alex Urbanski. All rights reserved.
//

import UIKit
import Firebase

class SearchTableViewCell: UITableViewCell {
    var posting: Posting?
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var textbookImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func addToCartPressed(_ sender: Any) {
        Database.database().reference().child("Carts").queryOrdered(byChild: "userID").queryEqual(toValue: Auth.auth().currentUser?.uid).observeSingleEvent(of: .childAdded) { (snapshot) in
            snapshot.ref.child("Postings").updateChildValues([self.posting!.uid: true])
        }
    }
}
