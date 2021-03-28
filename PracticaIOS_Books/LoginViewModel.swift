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

    
    init(userManager: UserManager) {
        self.userManager = userManager
        self.userValidator = UserViewModel()
        self.userManager.delegate = self
    }
    
    func validateAndLogin(username: String, password: String) -> Bool{
        
        if userValidator.validateUsername(username: username) && userValidator.validatePassword(password: password) {
            if userManager.checkLogin(username: username, password: password) {
                return true
            }
        }
        
        return false
    }
    
    func userSession(_: UserManager, didUserChange user: User) {
        delegate?.userSession(self, didUserChange: user)
    }
}

protocol LoginViewModelDelegate: class {
    func userSession(_: LoginViewModel, didUserChange user: User)
}
