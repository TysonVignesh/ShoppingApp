//
//  CartListController.swift
//  ShoppingApp
//
//  Created by Tyson Cath on 22/04/19.
//  Copyright © 2019 Tyson. All rights reserved.
//

import UIKit
import moltin

class CartListController: UIViewController {

    @IBOutlet var cartListTableView: UITableView!
    var products: [CartItem]? = nil {
        didSet {
            DispatchQueue.main.async {
                self.cartListTableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.cartListTableView.tableFooterView = .init()
        viewInIt()
    }
    
    private func viewInIt() {
        navigationItem.title = "Cart"
        
        MoltinHelper.getCartList { (success, productList, error) in
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

extension CartListController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let products = products {
            if let productCell = tableView.dequeueReusableCell(withIdentifier: "ProductListCell", for: indexPath) as? ProductListCell {
                productCell.titleLabel.text = products[indexPath.row].name
                productCell.descriptionLabel.text = products[indexPath.row].description
                var price = "$ " + String(products[indexPath.row].unitPrice.amount)
                price.insert(".", at: price.index(price.startIndex, offsetBy: price.count - 2))
                productCell.priceLabel.text = price
                return productCell
            }
        }
        
        return .init()
    }
}

extension CartListController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            if let products = products {
                moltinInstance.cart.removeItem(products[indexPath.row].id, fromCart: cartID!) { (item) in
                    self.viewInIt()
                    debugPrint(item)
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let alertController = UIAlertController.init(title: "Add to cart", message: "Click add to include this product to your cart", preferredStyle: .alert)
//        let okAction = UIAlertAction.init(title: "Add", style: .default) { (action) in
//            tableView.deselectRow(at: indexPath, animated: true)
//        }
//        alertController.addAction(okAction)
//        let cancelAction = UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil)
//        alertController.addAction(cancelAction)
//        self.present(alertController, animated: true, completion: nil)
    }
}







