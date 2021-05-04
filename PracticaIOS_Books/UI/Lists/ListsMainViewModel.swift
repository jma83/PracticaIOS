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
        //TODO
        // call userManager to retrieve current user
        // call listManagerMethod to retrieve Lists for this user
        var list = ListResult()
        list.name = "Pepe"
        list.date = Date()
        var list2 = ListResult()
        list2.name = "Juan"
        list2.date = Date()
        listViewModels = [ListViewModel(list:list),ListViewModel(list:list2)]
    }
    
    
    func listsResult(_: ListManager, didListChange list: [List]) {
        //TODO
        print(list)
        //Event recieved from ListManager
    }
    
    func deleteList(listViewModel: ListViewModel){
        // self.listManager.deleteList(name: listViewModel.name)
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

