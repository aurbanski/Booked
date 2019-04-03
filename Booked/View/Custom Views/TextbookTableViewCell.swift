//
//  TextbookTableViewCell.swift
//  Booked
//
//  Created by Alex Urbanski on 4/2/19.
//  Copyright © 2019 Alex Urbanski. All rights reserved.
//

import UIKit

class TextbookTableViewCell: UITableViewCell {
    var posting: Posting?
    
    @IBOutlet weak var bookImageView: UIImageView!
    @IBOutlet weak var priceTextField: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    @IBAction func addToCartPressed(_ sender: Any) {
//        if let postingForHandler = posting {
//            
//        }
    }
    
}
