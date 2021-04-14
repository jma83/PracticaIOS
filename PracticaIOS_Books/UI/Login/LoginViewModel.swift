//
//  LoginViewModel.swift
//  PracticaIOS_Books
//
//  Created by Javier Martinez on 27/03/2021.
//

import Foundation

class LoginViewModel: UserManagerDelegate {
    

    private let userManager: UserManager
    let userValidator: UserViewModel
    weak var delegate: LoginViewModelDelegate?
    weak var routingDelegate: WelcomeViewModelRoutingDelegate?

    
    init(userManager: UserManager) {
        self.userManager = userManager
        self.userValidator = UserViewModel()
        self.userManager.delegate = self
    }
    
    func validateAndLogin(username: String, password: String) -> Void{
        
        if userValidator.validateLogin(username: username,password: password) {
            userManager.checkLogin(username: username, password: password)
                //routingDelegate?.userWantsToLogin(self)
        }else{
            self.userCredentialError(self.userManager,error: userValidator.getError())
        }
    }
    
    func userSession(_: UserManager, didUserChange user: User) {
        routingDelegate?.userAccessAllowed()
    }
    

    func userCredentialError(_: UserManager, error: String) {
        delegate?.userLoginError(self, error: error)

    }
}

protocol LoginViewModelDelegate: class {
    func userLoginError(_: LoginViewModel, error: String)
}

protocol LoginViewModelRoutingDelegate: class {
    func userWantsToLogin(_: LoginViewModel)
}
