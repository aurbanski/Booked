//
//  TransactionService.swift
//  Booked
//
//  Created by Alex Urbanski on 4/13/19.
//  Copyright © 2019 Alex Urbanski. All rights reserved.
//

import UIKit

class TransactionService {
    func attemptPurchase(cost: Int, address: Address, creditCard: CreditCard) -> Int {
        sleep(1)
        
        if checkCreditCard(card: creditCard) && checkAddress(address: address) {
            return cost
        } else {
            return -1
        }
    }
    
    func checkCreditCard(card: CreditCard) -> Bool {
        if checkParameter(card.name) && checkParameter(card.cardNumber) && checkParameter(card.expirationDate) && checkParameter(card.cvv) {
            return true
        } else {
            return false
        }
    }
    
    func checkAddress(address: Address) -> Bool {
        if checkBillingInformation(address: address) && checkShippingInformation(address: address) {
            return true
        } else {
            return false
        }
    }
    
    func checkBillingInformation(address: Address) -> Bool {
        return checkParameter(address.billingAddress) && checkParameter(address.billingName) && checkParameter(address.billingCity) && checkParameter(address.billingState) && checkParameter(address.billingZip)
    }
    
    func checkShippingInformation(address: Address) -> Bool {
        return checkParameter(address.shippingName) && checkParameter(address.shippingAddress) && checkParameter(address.shippingCity) && checkParameter(address.shippingState) && checkParameter(address.shippingZip)
    }
    
    func checkParameter(_ parameter: String) -> Bool {
        if parameter != "" {
            return true
        } else {
            return false
        }
    }
}
