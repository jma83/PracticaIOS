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
    @IBOutlet weak var birthdateText: UIDatePicker!
    @IBOutlet weak var genderOption: UISegmentedControl!
    private let viewModel: RegisterViewModel
    
    init(viewModel: RegisterViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        passwordText.isSecureTextEntry = true
        birthdateText.maximumDate = Date()

        // Do any additional setup after loading the view.
    }
    
  
    @IBAction func clickRegisterButton() {
 
        let username = usernameText.text
        let pass = passwordText.text
        let email = emailText.text
        
        let birthdate = birthdateText?.date
        let gender = genderOption.titleForSegment(at:genderOption.selectedSegmentIndex)
        let country = countryText.text
        
        let res = viewModel.validateAndRegister(username: username!, password: pass!, email: email!, birthdate: birthdate!, country: country!)
        if res != nil{
            showAlert(title: "Error", message: res!)
        }
     //            performSegue(withIdentifier: "registerToHome", sender: self)

    }
    
    func userSession(_: RegisterViewModel, didUserChange user: User) {
        //prepare transition
    }
    
    func showAlert(title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: { action in
            print("salir")
        }))
        
        present(alert, animated: true)
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
