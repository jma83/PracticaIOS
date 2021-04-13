//
//  RegisterViewController.swift
//  PracticaIOS_Books
//
//  Created by Javier Martinez on 20/03/2021.
//

import UIKit

class RegisterViewController: UIViewController, RegisterViewModelDelegate {

    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var usernameText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var countryText: UITextField!
    @IBOutlet weak var genderOption: UISegmentedControl!
    @IBOutlet weak var birthdatePicker: UIDatePicker!
    var viewModel: RegisterViewModel
    let datePicker = UIDatePicker()
    
    init(viewModel: RegisterViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.viewModel.delegate = self
    }
    
    required init?(coder: NSCoder) {
        self.viewModel = RegisterViewModel(userManager: UserManager())
        super.init(coder: coder)
        self.viewModel.delegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        passwordText.isSecureTextEntry = true
        birthdatePicker.datePickerMode = .date
    }
    
  
    @IBAction func clickRegisterButton() {
        
        let username = usernameText.text
        let pass = passwordText.text
        let email = emailText.text
        let date = birthdatePicker.date
        let gender = genderOption.selectedSegmentIndex
        let country = countryText.text
        
        viewModel.validateAndRegister(username: username!, password: pass!, email: email!, gender: gender, birthdate: date, country: country!)
    }
    
    func dateFormatter() -> DateFormatter{
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .none
        
        return dateFormatter
    }
    
    func userSession(_: RegisterViewModel, didUserChange user: User) {
        let homeViewController = storyboard?.instantiateViewController(withIdentifier: "NavHomeViewController") as! UINavigationController
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window?.rootViewController = homeViewController
        homeViewController.modalPresentationStyle = .overCurrentContext
        present(homeViewController, animated: true)
    }
    
    func userRegisterError(_: RegisterViewModel, error: String) {
        present(ModalViewController().showAlert(title: "Error", message: error), animated: true)
    }

}
