//
//  MoltinHelper.swift
//  ShoppingApp
//
//  Created by Tyson Cath on 22/04/19.
//  Copyright © 2019 Tyson. All rights reserved.
//

import Foundation
import moltin
import IHProgressHUD

let moltinInstance = Moltin.init(withClientID: "VOgaCzF0voklqLKy4v7qRNJS36cBwrmiKSsrhYG9kZ")

class MoltinHelper {
    static func getProducts(completionHandler: @escaping ((_ success: Bool, _ data: [Product]?, _ error: Error?)
        ->())) {
        IHProgressHUD.show()
        moltinInstance.product.all { result in
            IHProgressHUD.dismiss()
            switch result {
            case .success(let response):
                completionHandler(true, response.data, nil)
                break
            case .failure(let error):
                completionHandler(false, nil, error)
                break
            }
        }
    }
    
    
    static func getCartList(completionHandler: @escaping ((_ success: Bool, _ data: [CartItem]?, _ error: Error?)
        ->())) {
        if let cartID = cartID {
            IHProgressHUD.show()
            moltinInstance.cart.items(forCartID: cartID, completionHandler: { (result) in
                IHProgressHUD.dismiss()
                switch result {
                case .success(let response):
                    completionHandler(true, response.data, nil)
                    break
                case .failure(let error):
                    completionHandler(false, nil, error)
                    break
                }
            })
        }
    }
}

