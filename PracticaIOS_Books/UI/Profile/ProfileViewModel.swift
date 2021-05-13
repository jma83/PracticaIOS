//
//  ProfileViewModel.swift
//  PracticaIOS_Books
//
//  Created by Javier Martinez on 10/05/2021.
//

import Foundation

class ProfileViewModel: UserManagerProfileDelegate {
    
    
    private let userSession: User
    private let userManager: UserManager
    weak var delegate: ProfileViewModelDelegate?
    weak var routingDelegate: ProfileViewModelRoutingDelegate?
    
    init(userManager: UserManager, userSession: User) {
        self.userManager = userManager
        self.userSession = userSession
        self.userManager.profileDelegate = self
    }
    
    func getUserInfo(){
        self.delegate?.getUserInfoResult(self, user: userSession)
    }
    
    func updateUser(email: String, username: String, birthdate: Date, gender: Int, country: String){
        let userVM = UserViewModel(email: email, username: username, birthdate: birthdate, gender: Int16(gender), country: country)
        if (!userVM.validateUpdate()) {
            self.updateUserError(self.userManager,message: userVM.getError())
        }else{
            self.userManager.updateUserInfo(userResult: userVM.user, user: userSession)
        }
    }
    
    func changePasswordEvent(){
        self.routingDelegate?.changePassword(self)
    }
    
    func closeProfileRouting(){
        self.routingDelegate?.closeProfile(self)
    }
    
    // MARK: UserManagerProfileDelegate functions
    
    func updateUserResult(_: UserManager, message: String) {
        self.routingDelegate?.showModalInfo(title: "Success", message: message)
    }
    
    func updateUserError(_: UserManager, message: String) {
        self.routingDelegate?.showModalInfo(title: "Error", message: message)
    }
}

protocol ProfileViewModelDelegate: class {
    func getUserInfoResult(_: ProfileViewModel, user: User)
}

protocol ProfileViewModelRoutingDelegate: class {
    func showModalInfo(title: String, message: String)
    func changePassword(_: ProfileViewModel)
    func closeProfile(_: ProfileViewModel)
}
