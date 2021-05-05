//
//  CreateListViewModel.swift
//  PracticaIOS_Books
//
//  Created by Javier Martinez on 25/04/2021.
//

import Foundation

class CreateListViewModel: AddListManagerDelegate {

    weak var delegate: CreateListViewModelDelegate?
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
        self.routingDelegate?.createListResult()

    }
    
    func listError(_: ListManager, error: String) {
        delegate?.listError(self, message: error)
    }

}

protocol CreateListViewModelDelegate: class {
    func listError(_: CreateListViewModel, message: String)
}

protocol CreateListViewModelRoutingDelegate: class {
    func createListResult()
}
