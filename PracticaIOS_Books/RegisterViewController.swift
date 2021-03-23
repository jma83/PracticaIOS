//
//  RegisterViewController.swift
//  PracticaIOS_Books
//
//  Created by Javier Martinez on 20/03/2021.
//

import UIKit

class RegisterViewController: UIViewController {

    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var usernameText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var countryText: UITextField!
    @IBOutlet weak var birthdateText: UIDatePicker!
    override func viewDidLoad() {
        super.viewDidLoad()
        passwordText.isSecureTextEntry = true

        // Do any additional setup after loading the view.
    }
    
    @IBAction func looseFocusText(_ sender: UITextField) {
    }
    
    @IBAction func clickRegisterButton() {
        //check email ok
        //check username ok
        //check pass ok
        //check birtdate > 18
        //create and transition
        //let u = User()
        let email = emailText?.text
        let username = usernameText?.text
        let pass = passwordText?.text
        let birthdate = birthdateText?.date
        let country = countryText?.text

        
        if email != "" && username != "" && pass != "" && birthdate != nil && country != ""{
            UserManager().saveUser(username: username!, password: pass!, email: email!, birthdate: birthdate ?? Date(), country: country!)
        }
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
