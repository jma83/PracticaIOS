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
    private let viewModel: RegisterViewModel
    let datePicker = UIDatePicker()
    
    init(viewModel: RegisterViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        self.viewModel = RegisterViewModel(userManager: UserManager())
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        passwordText.isSecureTextEntry = true
        birthdatePicker.datePickerMode = .date
        // createdDatePicker()
        // Do any additional setup after loading the view.
    }
    
  
    @IBAction func clickRegisterButton() {
        
        let username = usernameText.text
        let pass = passwordText.text
        let email = emailText.text
        let date = birthdatePicker.date
        let gender = genderOption.selectedSegmentIndex
        let country = countryText.text
        
        let res = viewModel.validateAndRegister(username: username!, password: pass!, email: email!, gender: gender, birthdate: date, country: country!)
        if let res = res{
            present(ModalViewController().showAlert(title: "Error", message: res), animated: true)
        }

    }
    
    func dateFormatter() -> DateFormatter{
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .none
        
        return dateFormatter
    }
    
    func userSession(_: RegisterViewModel, didUserChange user: User) {
        performSegue(withIdentifier: "registerToHome", sender: self)
    }
    

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
