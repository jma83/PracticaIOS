//
//  RegisterViewModel.swift
//  PracticaIOS_Books
//
//  Created by Javier Martinez on 27/03/2021.
//

import Foundation

class RegisterViewModel: UserManagerDelegate {

    private let userManager: UserManager
    let userValidator: UserViewModel
    weak var delegate: RegisterViewModelDelegate?
    weak var routingDelegate: WelcomeViewModelRoutingDelegate?

    
    init(userManager: UserManager) {
        self.userManager = userManager
        self.userValidator = UserViewModel()
        self.userManager.delegate = self

    }
    
    func validateAndRegister(username: String, password: String, email: String, gender: Int, birthdate: Date, country: String) -> Void {
        
        if !userValidator.validateEmail(email: email) || !userValidator.validateUsername(username: username) || !userValidator.validatePassword(password: password)  || !userValidator.validateDate(date: birthdate) || !userValidator.validateGender(gender: gender) || !userValidator.validateCountry(country: country) {
            
            userCredentialError(self.userManager,error: userValidator.getError())
        }else{
            userManager.saveUser(username: username, password: password, email: email, gender: gender, birthdate: birthdate, country: country)
        }
        
    }
    
    func userSession(_: UserManager, didUserChange user: User) {
        routingDelegate?.userAccessAllowed(userSession: user)
    }
    
    func userCredentialError(_: UserManager, error: String) {
        delegate?.userRegisterError(self, error: error)
    }
    
}
protocol RegisterViewModelDelegate: class {
    func userRegisterError(_: RegisterViewModel, error: String)
}
