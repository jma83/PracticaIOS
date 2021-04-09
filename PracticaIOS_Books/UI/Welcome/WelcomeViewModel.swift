//
//  WelcomeViewModel.swift
//  PracticaIOS_Books
//
//  Created by Javier Martinez on 07/04/2021.
//

import Foundation

class WelcomeViewModel: UserManagerDelegate {
    
    let userManager: UserManager
    weak var delegate: WelcomeViewModelDelegate?
    
    init(userManager: UserManager) {
        self.userManager = userManager
        self.userManager.delegate = self
        
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
    
}

protocol WelcomeViewModelDelegate: class {
    func userFound(_: UserManager, user: User)
}
