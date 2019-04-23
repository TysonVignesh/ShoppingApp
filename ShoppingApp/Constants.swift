//
//  Constants.swift
//  ShoppingApp
//
//  Created by Tyson Cath on 22/04/19.
//  Copyright © 2019 Tyson. All rights reserved.
//

import Foundation

let kCartID: String = "CartID"

var cartID: String? {
    get {
        return UserDefaults.standard.string(forKey: kCartID)
    }
    set {
        UserDefaults.standard.set(newValue, forKey: kCartID)
        UserDefaults.standard.synchronize()
    }
}
