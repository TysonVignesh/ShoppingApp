//
//  CheckoutController.swift
//  ShoppingApp
//
//  Created by Tyson Cath on 23/04/19.
//  Copyright © 2019 Tyson. All rights reserved.
//

import UIKit
import moltin
import IHProgressHUD

class CheckoutController: UIViewController {

    @IBOutlet var firstNameTextField: UITextField!
    @IBOutlet var lastNameTextField: UITextField!
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var addressTextFiled: UITextField!
    @IBOutlet var streetTextField: UITextField!
    @IBOutlet var countryTextField: UITextField!
    @IBOutlet var postcodeTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewInIt()
    }
    
    func setUpMenuButton() {
        let menuBtn = UIButton(type: .custom)
        menuBtn.frame = CGRect(x: 0.0, y: 0.0, width: navigationController?.navigationBar.frame.height ?? 30, height: navigationController?.navigationBar.frame.height ?? 30)
        menuBtn.setImage(UIImage(named:"BackWhite"), for: .normal)
        menuBtn.addTarget(self, action: #selector(self.backAction), for: UIControl.Event.touchUpInside)
        
        let menuBarItem = UIBarButtonItem(customView: menuBtn)
        
        let checkoutButton = UIBarButtonItem.init(title: "Pay", style: .plain, target: self, action: #selector(self.checkoutAction(_:)))
        self.navigationItem.rightBarButtonItem = checkoutButton
        
        let currWidth = menuBarItem.customView?.widthAnchor.constraint(equalToConstant: navigationController?.navigationBar.frame.height ?? 30)
        currWidth?.isActive = true
        let currHeight = menuBarItem.customView?.heightAnchor.constraint(equalToConstant: navigationController?.navigationBar.frame.height ?? 30)
        currHeight?.isActive = true
        self.navigationItem.leftBarButtonItem = menuBarItem
    }
    
    @IBAction func backAction() {
        navigationController?.popViewController(animated: true)
    }
    
    private func viewInIt() {
        self.navigationItem.setHidesBackButton(true, animated: true)
        setUpMenuButton()
        navigationItem.title = "Checkout"
        
        firstNameTextField.text = firstName
        lastNameTextField.text = lastName
        emailTextField.text = email
        addressTextFiled.text = address
        streetTextField.text = street
        countryTextField.text = country
        postcodeTextField.text = postCode
    }
    
    @objc func checkoutAction(_ sender: UIBarButtonItem) {
        guard let firstNameValue = firstNameTextField.text, !firstNameValue.isEmpty else {
            self.showAlert(message: "Please enter first name")
            return
        }
        
        guard let lastNameValue = lastNameTextField.text, !lastNameValue.isEmpty else {
            self.showAlert(message: "Please enter last name")
            return
        }
        
        guard let emailValue = emailTextField.text, !emailValue.isEmpty else {
            self.showAlert(message: "Please enter email")
            return
        }
        
        guard let addressValue = addressTextFiled.text, !addressValue.isEmpty else {
            self.showAlert(message: "Please enter address")
            return
        }
        
        guard let streetValue = streetTextField.text, !streetValue.isEmpty else {
            self.showAlert(message: "Please enter street name")
            return
        }
        
        guard let countryValue = countryTextField.text, !countryValue.isEmpty else {
            self.showAlert(message: "Please enter country name")
            return
        }
        
        guard let postCodeValue = postcodeTextField.text, !postCodeValue.isEmpty else {
            self.showAlert(message: "Please enter postcode")
            return
        }
        
        firstName = firstNameValue
        lastName = lastNameValue
        email = emailValue
        address = addressValue
        street = streetValue
        country = countryValue
        postCode = postCodeValue
        
        let customer = Customer(withEmail: emailValue, withName: firstNameValue + " " + lastNameValue)
        let addressVar = Address(withFirstName: firstNameValue, withLastName: lastNameValue)
        addressVar.line1 = addressValue
        addressVar.county = streetValue
        addressVar.country = countryValue
        addressVar.postcode = postCodeValue
        
        view.endEditing(true)
        IHProgressHUD.show()
        moltinInstance.cart.checkout(cart: cartID!, withCustomer: customer, withBillingAddress: addressVar, withShippingAddress: nil) { (result) in
            IHProgressHUD.dismiss()
            switch result {
            case .success(let order):
                self.payForOrder(order)
            default: break
            }
        }
    }
    
    func payForOrder(_ order: Order) {
        let paymentMethod = ManuallyAuthorizePayment()
        IHProgressHUD.show()
        moltinInstance.cart.pay(forOrderID: order.id, withPaymentMethod: paymentMethod) { (result) in
            DispatchQueue.main.async {
                IHProgressHUD.dismiss()
                switch result {
                case .success:
                    self.showOrderStatus(withSuccess: true)
                case .failure(let error):
                    self.showOrderStatus(withSuccess: false, withError: error)
                }
            }
        }
    }
    
    func showAlert(message: String) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        let cancelAction = UIAlertAction.init(title: "Ok", style: .cancel, handler: nil)
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    func showOrderStatus(withSuccess success: Bool, withError error: Error? = nil) {
        let title = success ? "Order paid!" : "Order error"
        let message = success ? "Complete!" : error?.localizedDescription
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancelAction = UIAlertAction.init(title: "Ok", style: .cancel, handler: nil)
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)
        
        if success {
            UserDefaults.standard.removeObject(forKey: kCartID)
            UserDefaults.standard.synchronize()
        }
    }
}
