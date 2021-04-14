//
//  WelcomeViewModel.swift
//  PracticaIOS_Books
//
//  Created by Javier Martinez on 07/04/2021.
//

import Foundation

class WelcomeViewModel: UserManagerStartDelegate {
       
    let userManager: UserManager
    weak var delegate: WelcomeViewModelDelegate?
    weak var routingDelegate: WelcomeViewModelRoutingDelegate?
    
    init(userManager: UserManager) {
        self.userManager = userManager
        self.userManager.initialDelegate = self
        
    }
    
    func checkUser(){
        do {
            try self.userManager.retrieveUserSession()
        }catch{
            print("Error retrieving")
        }
    }
    
    func userSession(_: UserManager, didUserChange user: User) {
        delegate?.userFound(self.userManager, user: user)
    }
    
    public func handleUserAccess() {
        routingDelegate?.userWantsToAccess(self)
    }
    
    public func handleUserRegister() {
        routingDelegate?.userWantsToRegister(self)
    }
    
}

protocol WelcomeViewModelDelegate: class {
    func userFound(_: UserManager, user: User)
}

protocol WelcomeViewModelRoutingDelegate: class {
    func userWantsToAccess(_: WelcomeViewModel)
    func userWantsToRegister(_: WelcomeViewModel)
    func userAccessAllowed()
}
