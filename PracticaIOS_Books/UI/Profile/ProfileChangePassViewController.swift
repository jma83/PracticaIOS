//
//  ProfileChangePassViewController.swift
//  PracticaIOS_Books
//
//  Created by Javier Martinez on 10/05/2021.
//

import UIKit

class ProfileChangePassViewController: UIViewController {

    @IBOutlet weak var currentPassField: UITextField!
    @IBOutlet weak var newPassField: UITextField!
    @IBOutlet weak var confirmButton: UIButton!
    private let viewModel: ProfileChangePassViewModel
    override func viewDidAppear(_ animated: Bool) {
        currentPassField.isSecureTextEntry = true
        newPassField.isSecureTextEntry = true
    }
    
    init(viewModel: ProfileChangePassViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        title = "Profile password"

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @IBAction func onClickConfirm(_ sender: Any) {
        viewModel.changePassEvent(newPass: newPassField.text!, oldPass: currentPassField.text!)
    }
    
}
