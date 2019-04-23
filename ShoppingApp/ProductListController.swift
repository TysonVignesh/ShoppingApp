//
//  ViewController.swift
//  ShoppingApp
//
//  Created by Tyson Cath on 22/04/19.
//  Copyright © 2019 Tyson. All rights reserved.
//

import UIKit
import AlamofireImage
import moltin

class ProductListController: UIViewController {
    
    @IBOutlet var productsTableView: UITableView!

    var products: [Product]? = nil {
        didSet {
            DispatchQueue.main.async {
                self.productsTableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.productsTableView.tableFooterView = .init()
        viewInIt()
    }
    
    private func viewInIt() {
        MoltinHelper.getProducts { (success, productList, error) in
            if success {
                self.products = productList
            }
        }
        
        if let cartID = cartID {
            moltinInstance.cart.items(forCartID: cartID) { (result) in
                debugPrint(result)
            }
        }
    }
}

extension ProductListController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let products = products {
            if let productCell = tableView.dequeueReusableCell(withIdentifier: "ProductListCell", for: indexPath) as? ProductListCell {
                productCell.titleLabel.text = products[indexPath.row].name
                productCell.descriptionLabel.text = products[indexPath.row].description
                productCell.priceLabel.text = "$ " + String(products[indexPath.row].price?.first?.amount ?? 0)
                return productCell
            }
        }
        
        return .init()
    }
}

extension ProductListController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let alertController = UIAlertController.init(title: "Add to cart", message: "Click add to include this product to your cart", preferredStyle: .alert)
        let okAction = UIAlertAction.init(title: "Add", style: .default) { (action) in
            tableView.deselectRow(at: indexPath, animated: true)
            
            if let cartID = cartID {
                moltinInstance.cart.addProduct(withID: self.products![indexPath.row].id, ofQuantity: 1, toCart: cartID, completionHandler: { (result) in
                    debugPrint("Added product to cart \(result)")
                })
            } else {
                let newCartID = UUID().uuidString
                cartID = newCartID
                moltinInstance.cart.addProduct(withID: self.products![indexPath.row].id, ofQuantity: 1, toCart: newCartID, completionHandler: { (result) in
                    debugPrint("Added product to cart \(result)")
                })
            }
        }
        alertController.addAction(okAction)
        let cancelAction = UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
    }
}







