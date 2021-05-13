//
//  CreateListViewModel.swift
//  PracticaIOS_Books
//
//  Created by Javier Martinez on 25/04/2021.
//

import Foundation

class CreateListViewModel: AddListManagerDelegate {

    weak var routingDelegate: CreateListViewModelRoutingDelegate?
    let listManager: ListManager
    let userSession: User

    init(listManager: ListManager, userSession: User) {
        self.listManager = listManager
        self.userSession = userSession
        self.listManager.delegateAdd = self
    }
    
    func createList(listName: String){
        listManager.createList(name: listName, user: userSession)
    }
    
    func listUpdatedResult(_: ListManager, didListChange list: List) {
        self.routingDelegate?.createListResult(self)
    }
    
    func listError(_: ListManager, error: String) {
        self.routingDelegate?.showInfoModal(title: "Error", message: error)
    }

}

protocol CreateListViewModelRoutingDelegate: class {
    func createListResult(_: CreateListViewModel)
    func showInfoModal(title: String, message: String)

}
