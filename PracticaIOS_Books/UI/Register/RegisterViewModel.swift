//
//  RegisterViewModel.swift
//  PracticaIOS_Books
//
//  Created by Javier Martinez on 27/03/2021.
//

import Foundation

class RegisterViewModel: UserManagerDelegate {

    private let userManager: UserManager
    var userViewModel: UserViewModel?
    weak var routingDelegate: WelcomeViewModelRoutingDelegate?

    
    init(userManager: UserManager) {
        self.userManager = userManager
        self.userManager.delegate = self

    }
    
    func validateAndRegister(username: String, password: String, email: String, gender: Int, birthdate: Date, country: String) -> Void {
        
        userViewModel = UserViewModel(email: email, username: username, birthdate: birthdate, gender: Int16(gender), country: country, password: password)
        if let userVM = userViewModel {
            if userVM.validateRegister() {
                userManager.saveUser(userResult: userVM.user)
            
            }else{
                userCredentialError(self.userManager,error: userVM.getError())
                
            }
        }
        
    }
    
    func userSession(_: UserManager, didUserChange user: User) {
        routingDelegate?.userAccessAllowed(userSession: user)
    }
    
    func userCredentialError(_: UserManager, error: String) {
        routingDelegate?.showInfoModal(title: "Error", message: error)
    }
    
}
