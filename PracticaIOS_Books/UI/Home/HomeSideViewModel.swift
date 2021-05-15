//
//  HomeSideViewModel.swift
//  PracticaIOS_Books
//
//  Created by Javier Martinez on 15/05/2021.
//

import Foundation

class HomeSideViewModel: UserHomeManagerDelegate {
    
    private let userManager: UserManager
    weak var routingDelegate: HomeSideViewModelRouting?
    
    init(userManager: UserManager) {
        self.userManager = userManager
        self.userManager.homeDelegate = self
    }
        
    func userLogout(){
        self.userManager.removeUserSession()
    }
    
    func userProfileRouting(){
        routingDelegate?.showProfile(self)
    }
    
    func aboutRouting(){
        routingDelegate?.showAbout(self)
    }
    
    //MARK: UserHomeManagerDelegate functions
    
    func userLogoutResult(_: UserManager) {
        self.routingDelegate?.redirectToWelcome(self)
    }
    
    
}

protocol HomeSideViewModelRouting: class {
    func showProfile(_: HomeSideViewModel)
    func showAbout(_: HomeSideViewModel)
    func redirectToWelcome(_: HomeSideViewModel)
}
