//
//  CartTableViewCell.swift
//  Booked
//
//  Created by Alex Urbanski on 4/5/19.
//  Copyright © 2019 Alex Urbanski. All rights reserved.
//

import UIKit

class ShadowView: UIView {
    override var bounds: CGRect {
        didSet {
            setupShadow()
        }
    }
    
    private func setupShadow() {
        self.layer.cornerRadius = 20.0
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.layer.shadowRadius = 6.0
        self.layer.shadowOpacity = 0.3
        self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: .allCorners, cornerRadii: CGSize(width: 8, height: 8)).cgPath
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = UIScreen.main.scale
    }
}

class CartTableViewCell: UITableViewCell {
    @IBOutlet weak var textbookImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var shadowLayerView: ShadowView!
    @IBOutlet weak var mainBackgroundView: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        mainBackgroundView.layer.cornerRadius = 20.0
        textbookImageView.roundCorners(corners: [.topRight, .bottomRight], radius: 20.0)
    }
}

extension UIImageView {
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
}
