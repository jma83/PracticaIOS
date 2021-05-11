//
//  WelcomeViewModel.swift
//  PracticaIOS_Books
//
//  Created by Javier Martinez on 07/04/2021.
//

import Foundation

class WelcomeViewModel: UserManagerStartDelegate {
    
    let userManager: UserManager
    
    weak var routingDelegate: WelcomeViewModelRoutingDelegate?
    
    init(userManager: UserManager) {
        self.userManager = userManager
        self.userManager.initialDelegate = self
        self.checkUser()
    }
    
    func checkUser(){
        self.userManager.retrieveUserSession(initial: true)
        
    }
    
    func userSession(_: UserManager, didUserChange user: User) {
        routingDelegate?.userAccessAllowed(userSession: user)
    }
    
    func userSessionError(_: UserManager, message: String) {
        self.routingDelegate?.showInfoModal(title: "Error", message: message)
    }
    
    public func handleUserAccess() {
        routingDelegate?.userWantsToAccess(self)
    }
    
    public func handleUserRegister() {
        routingDelegate?.userWantsToRegister(self)
    }
    
}

protocol WelcomeViewModelRoutingDelegate: class {
    func userWantsToAccess(_: WelcomeViewModel)
    func userWantsToRegister(_: WelcomeViewModel)
    func userAccessAllowed(userSession: User)
    func showInfoModal(title: String, message: String)
}
