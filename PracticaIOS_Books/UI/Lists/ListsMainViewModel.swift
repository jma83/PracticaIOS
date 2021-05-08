//
//  ListsMainViewModel.swift
//  PracticaIOS_Books
//
//  Created by Javier Martinez on 01/05/2021.
//

import Foundation

class ListsMainViewModel: ListManagerDelegate {
    var listViewModels: [ListViewModel] = []
    let listManager: ListManager
    var userSession: User?
    weak var delegate: ListsMainViewModelDelegate?
    weak var routingDelegate: ListsMainViewModelRoutingDelegate?
    init(listManager: ListManager, userSession: User) {
        self.listManager = listManager
        self.userSession = userSession
        self.listManager.delegate = self
    }
    
    func retrieveLists() {
        if let user = userSession {
            self.listManager.fetchAllByUser(user: user)
        }

    }
    
    
    func listsResult(_: ListManager, didListChange lists: [List]) {
        self.listViewModels = []
        for item in lists {
            self.listViewModels.append(ListViewModel(list: item))
            
        }
        self.delegate?.updateList(self)
    }
    
    func deleteList(listViewModel: ListViewModel){
        self.listManager.deleteList(name: listViewModel.name)
    }
    
    func createListRouting(){
        if let user = self.userSession {
           self.routingDelegate?.createList(self, userSession: user)
        }
    }
    
    func showListRouting(listViewModel: ListViewModel){
        if let user = self.userSession {
           self.routingDelegate?.showBooksFromList(self, listViewModel: listViewModel, userSession: user)
        }
    }
}


protocol ListsMainViewModelDelegate: class {
    func updateList(_: ListsMainViewModel)
    func deleteListResult(_: ListsMainViewModel)
}

protocol ListsMainViewModelRoutingDelegate: class {
    func createList(_: ListsMainViewModel, userSession: User)
    func showBooksFromList(_: ListsMainViewModel, listViewModel: ListViewModel, userSession: User)
}

