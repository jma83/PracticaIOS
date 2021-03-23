//
//  LoginViewController.swift
//  PracticaIOS_Books
//
//  Created by Javier Martinez on 20/03/2021.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var usernameText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        passwordText.isSecureTextEntry = true
        // Do any additional setup after loading the view.
    }
    
    @IBAction func clickLoginButton() {
        //checkuser
        //checkpass
        //check bd
        //ok -> transition
        let username = usernameText?.text
        let password = passwordText?.text
                
        let users = UserManager().checkLogin(username: username!, password: password!)
        
        print(users.count)
        for u in users{
            print(u.username ?? "")
            
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
