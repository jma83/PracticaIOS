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
    let userManager: UserManager

    init(listManager: ListManager, userManager: UserManager) {
        self.listManager = listManager
        self.userManager = userManager
        
    }
    
    func createList(listName: String){
        //TODO
        //listManager.createList(name: listName)
        listUpdatedResult(self.listManager, didListChange: List())
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
