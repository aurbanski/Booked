//
//  TextbookTableViewCell.swift
//  Booked
//
//  Created by Alex Urbanski on 4/2/19.
//  Copyright © 2019 Alex Urbanski. All rights reserved.
//

import UIKit

class TextbookTableViewCell: UICollectionViewCell {
    var posting: Posting?
    
    override var bounds: CGRect {
        didSet {
            setupShadow()
        }
    }

    private func setupShadow() {
        self.layer.cornerRadius = 15
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.layer.shadowRadius = 8
        self.layer.shadowOpacity = 0.3
        self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: .allCorners, cornerRadii: CGSize(width: 8, height: 8)).cgPath
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = UIScreen.main.scale
    }
    
    
    
    @IBOutlet weak var bookImageView: UIImageView!
    @IBOutlet weak var priceTextField: UILabel!
    @IBOutlet weak var backView: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        bookImageView.layer.masksToBounds = true
        backView.layer.cornerRadius = 15
    }
    
    @IBAction func addToCartPressed(_ sender: Any) {
//        if let postingForHandler = posting {
//            
//        }
    }
    
}
