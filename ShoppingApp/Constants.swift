//
//  Constants.swift
//  ShoppingApp
//
//  Created by Tyson Cath on 22/04/19.
//  Copyright © 2019 Tyson. All rights reserved.
//

import Foundation

let kCartID: String = "CartID"
let kFirstName: String = "FirstName"
let kLastName: String = "LastName"
let kEmail: String = "Email"
let kAddress: String = "Address"
let kStreet: String = "Street"
let kCountry: String = "Country"
let kPostCode: String = "PostCode"


var cartID: String? {
    get {
        return UserDefaults.standard.string(forKey: kCartID)
    }
    set {
        UserDefaults.standard.set(newValue, forKey: kCartID)
        UserDefaults.standard.synchronize()
    }
}

var firstName: String? {
    get {
        return UserDefaults.standard.string(forKey: kFirstName)
    }
    set {
        UserDefaults.standard.set(newValue, forKey: kFirstName)
        UserDefaults.standard.synchronize()
    }
}

var lastName: String? {
    get {
        return UserDefaults.standard.string(forKey: kLastName)
    }
    set {
        UserDefaults.standard.set(newValue, forKey: kLastName)
        UserDefaults.standard.synchronize()
    }
}

var email: String? {
    get {
        return UserDefaults.standard.string(forKey: kEmail)
    }
    set {
        UserDefaults.standard.set(newValue, forKey: kEmail)
        UserDefaults.standard.synchronize()
    }
}

var address: String? {
    get {
        return UserDefaults.standard.string(forKey: kAddress)
    }
    set {
        UserDefaults.standard.set(newValue, forKey: kAddress)
        UserDefaults.standard.synchronize()
    }
}

var street: String? {
    get {
        return UserDefaults.standard.string(forKey: kStreet)
    }
    set {
        UserDefaults.standard.set(newValue, forKey: kStreet)
        UserDefaults.standard.synchronize()
    }
}

var country: String? {
    get {
        return UserDefaults.standard.string(forKey: kCountry)
    }
    set {
        UserDefaults.standard.set(newValue, forKey: kCountry)
        UserDefaults.standard.synchronize()
    }
}

var postCode: String? {
    get {
        return UserDefaults.standard.string(forKey: kPostCode)
    }
    set {
        UserDefaults.standard.set(newValue, forKey: kPostCode)
        UserDefaults.standard.synchronize()
    }
}


