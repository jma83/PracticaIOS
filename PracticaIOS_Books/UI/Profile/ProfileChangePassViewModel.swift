//
//  ProfileChangePassViewModel.swift
//  PracticaIOS_Books
//
//  Created by Javier Martinez on 11/05/2021.
//

import Foundation

class ProfileChangePassViewModel: UserManagerProfilePassDelegate {
       
    var userViewModel: UserViewModel?
    private let userSession: User
    private let userManager: UserManager
    weak var routingDelegate: ProfileViewModelRoutingDelegate?
    
    init(userManager: UserManager, userSession: User) {
        self.userManager = userManager
        self.userSession = userSession
        self.userManager.profilePassDelegate = self
    }
    
    func changePassEvent(newPass: String, oldPass: String) {
        userViewModel = UserViewModel(password: newPass)
        if let userVM = self.userViewModel{
            if  userVM.validatePasswords(newPass: newPass, oldPass: oldPass) {
                
                self.userManager.updateUserPass(newPass: newPass, oldPass: oldPass, user: userSession)
            }else{
                updateUserError(self.userManager, message: userVM.getError())
            }
        }
    }
    
    func updateUserResult(_: UserManager, message: String) {
        self.routingDelegate?.showModalInfo(title: "Success", message: message)
    }
    
    func updateUserError(_: UserManager, message: String) {
        self.routingDelegate?.showModalInfo(title: "Error", message: message)
    }
    
}
