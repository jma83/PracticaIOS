//
//  AboutViewModel.swift
//  PracticaIOS_Books
//
//  Created by Javier Martinez on 15/05/2021.
//

import Foundation

class AboutViewModel {
    
    weak var routingDelegate: AboutViewModelRoutingDelegate?
    
    func closeAboutRouting() {
        self.routingDelegate?.closeAbout()
    }
}

protocol AboutViewModelRoutingDelegate: class {
    func closeAbout()
}
