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
    
    func validateAndRegister(username: String, password: String, email: String, birthdate: Date, country: String) -> String?{
        
        if !userValidator.validateUsername(username: username){
            return "Error, formato de username incorrecto"
        }
        if !userValidator.validatePassword(password: password){
            return "Error, formato de password no valido"
        }
        if !userValidator.validateEmail(email: email){
            return "Error, formato de email no valido"
        }
        if !userValidator.validateDate(date: birthdate){
            return "Error, formato de birthdate no valido"
        }
        if !userValidator.validateCountry(country: country){
            return "Error, formato de pais no valido"
        }
            
        let users = userManager.fetchByUsername(username: username)

        if users.count == 0 {
            userManager.saveUser(username: username, password: password, email: email, birthdate: birthdate, country: country)
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
