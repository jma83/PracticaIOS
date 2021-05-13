//
//  LoginViewModel.swift
//  PracticaIOS_Books
//
//  Created by Javier Martinez on 27/03/2021.
//

import Foundation

class LoginViewModel: UserManagerDelegate {
    

    private let userManager: UserManager
    var userViewModel: UserViewModel?
    weak var routingDelegate: WelcomeViewModelRoutingDelegate?

    
    init(userManager: UserManager) {
        self.userManager = userManager
        self.userManager.delegate = self
    }
    
    func validateAndLogin(username: String, password: String) -> Void{
        
        self.userViewModel = UserViewModel(username: username, password: password)
        if let userVM = userViewModel {
            if !userVM.validateLogin() {
                self.userCredentialError(self.userManager,error: userVM.getError())
                
            }else{
                userManager.checkLogin(userResult: userVM.user)
            }
        }
    }
    
    // MARK: UserManagerDelegate functions
    
    func userSession(_: UserManager, didUserChange user: User) {
        routingDelegate?.userAccessAllowed(userSession: user)
    }
    

    func userCredentialError(_: UserManager, error: String) {
        routingDelegate?.showInfoModal(title: "Error", message: error)

    }
}

protocol LoginViewModelRoutingDelegate: class {
    func userWantsToLogin(_: LoginViewModel)
}
