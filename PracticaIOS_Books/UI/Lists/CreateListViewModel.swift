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
        let listVM = ListViewModel(name: listName, date: Date())
        if !listVM.validate() {
            self.listError(self.listManager, error: listVM.getError())
        }else{
            listManager.createList(listResult: listVM.listResult!, user: userSession)
        }
        
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
