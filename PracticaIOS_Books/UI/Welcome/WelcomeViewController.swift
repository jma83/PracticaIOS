//
//  WelcomeViewController.swift
//  PracticaIOS_Books
//
//  Created by Javier Martinez on 18/03/2021.
//

import UIKit
import pop

class WelcomeViewController: UIViewController, UINavigationControllerDelegate {

    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    
    private let viewModel: WelcomeViewModel
    
    init(viewModel: WelcomeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let anim = POPBasicAnimation(propertyNamed: kPOPViewAlpha) {
            anim.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName .easeInEaseOut)
            anim.fromValue = 0.0
            anim.duration = 3.0
            anim.toValue = 1.0
            loginButton.pop_add(anim, forKey: "fade1")
            registerButton.pop_add(anim, forKey: "fade2")
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    @IBAction func clickRegisterButton() {
        viewModel.handleUserRegister()
    }
    @IBAction func clickLoginButton() {
        viewModel.handleUserAccess()
    }
    

}

extension UIViewController {
    func hideKeyboardEvent() {
        let tabGesture = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tabGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tabGesture)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true;
    }
}
