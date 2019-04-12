//
//  Address.swift
//  Booked
//
//  Created by Alex Urbanski on 4/12/19.
//  Copyright © 2019 Alex Urbanski. All rights reserved.
//

class Address {
    var billingName: String = ""
    var billingAddress: String = ""
    var billingState: String = ""
    var billingCity: String = ""
    var billingZip: String = ""
    
    var shippingName: String = ""
    var shippingAddress: String = ""
    var shippingState: String = ""
    var shippingCity: String = ""
    var shippingZip: String = ""
    
    func markShippingSame() {
        shippingName = billingName
        shippingAddress = billingAddress
        shippingState = billingState
        shippingCity = billingCity
        shippingZip = billingZip
    }
    
    func clearShippingInfo() {
        shippingName = ""
        shippingAddress = ""
        shippingState = ""
        shippingCity = ""
        shippingZip = ""
    }
}
