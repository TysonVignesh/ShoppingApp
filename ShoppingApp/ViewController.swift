//
//  ViewController.swift
//  ShoppingApp
//
//  Created by Tyson Cath on 22/04/19.
//  Copyright © 2019 Tyson. All rights reserved.
//

import UIKit
import moltin

class ViewController: UIViewController {

    var products: [Product]? = nil
    @IBOutlet var productsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let moltin = Moltin(withClientID: "VOgaCzF0voklqLKy4v7qRNJS36cBwrmiKSsrhYG9kZ")

        moltin.product.all { result in
            switch result {
            case .success(let response):
//                print("data:", response.data)
                self.products = response.data
                break
            case .failure(let error):
                print(error)
                break
            }
        }
    }
}



