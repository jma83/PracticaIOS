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

    
    init(userManager: UserManager) {
        self.userManager = userManager
        self.userValidator = UserViewModel()
        self.userManager.delegate = self

    }
    
    func validateAndRegister(username: String, password: String, email: String, gender: Int, birthdate: Date, country: String) -> String?{
        
        if !userValidator.validateEmail(email: email) || !userValidator.validateUsername(username: username) || !userValidator.validatePassword(password: password)  || !userValidator.validateDate(date: birthdate) || !userValidator.validateGender(gender: gender) || !userValidator.validateCountry(country: country) {
            return userValidator.getError()
        }
            
        let users = userManager.fetchByUsername(username: username)

        if users.count == 0 {
            userManager.saveUser(username: username, password: password, email: email, gender: gender, birthdate: birthdate, country: country)
            return nil
        }
            
        return "Error, usuario ya existe"
    }
    
    func userSession(_: UserManager, didUserChange user: User) {
        delegate?.userSession(self, didUserChange: user)
    }
    
    

    
}
protocol RegisterViewModelDelegate: class {
    func userSession(_: RegisterViewModel, didUserChange user: User)
}
