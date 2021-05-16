//
//  ProfileViewController.swift
//  PracticaIOS_Books
//
//  Created by Javier Martinez on 10/05/2021.
//

import UIKit

class ProfileViewController: UIViewController, ProfileViewModelDelegate, UITextFieldDelegate {

    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var usernameText: UITextField!
    @IBOutlet weak var birthDatePicker: UIDatePicker!
    @IBOutlet weak var genderSelector: UISegmentedControl!
    @IBOutlet weak var countryText: UITextField!
    @IBOutlet weak var confirmButton: UIButton!
    @IBOutlet weak var changePassButton: UIButton!
    private let viewModel: ProfileViewModel
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardEvent()
        emailText.delegate = self
        usernameText.delegate = self
        countryText.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.viewModel.getUserInfo()
        birthDatePicker.datePickerMode = .date
    }
    
    init(viewModel: ProfileViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.viewModel.delegate = self
        title = "Profile"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Close", style: .done, target: self, action: #selector(closeProfileEvent))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @IBAction func onClickConfirm(_ sender: Any) {
        self.viewModel.updateUser(email: emailText.text!, username: usernameText.text!, birthdate: birthDatePicker.date, gender: genderSelector.selectedSegmentIndex, country: countryText.text!)
    }
    @IBAction func onClickChangePass(_ sender: Any) {
        self.viewModel.changePasswordEvent()
    }
    
    func getUserInfoResult(_: ProfileViewModel, user: User) {
        emailText.text = user.email
        usernameText.text = user.username
        birthDatePicker.date = user.birthdate!
        genderSelector.selectedSegmentIndex = Int(user.gender)
        countryText.text = user.country
    }
    
    @objc func closeProfileEvent(){
        self.viewModel.closeProfileRouting()
    }
    

}
