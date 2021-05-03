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
    let userManager: UserManager
    weak var delegate: ListsMainViewModelDelegate?
    weak var routingDelegate: ListsMainViewModelRoutingDelegate?
    init(listManager: ListManager, userManager: UserManager) {
        self.listManager = listManager
        self.userManager = userManager
        self.retrieveLists()
        
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
        //Event recieved from ListManager
    }
    
    func deleteList(listViewModel: ListViewModel){
        // self.listManager.deleteList(name: listViewModel.name)
    }
    
    func createListRouting(){
        self.routingDelegate?.createList()
    }
    
    func showListRouting(listViewModel: ListViewModel){
        self.routingDelegate?.showBooksFromList(listViewModel: listViewModel)
    }
    
    
}


protocol ListsMainViewModelDelegate: class {
    func updateList(_: ListsMainViewModel)
    func deleteListResult(_: ListsMainViewModel)
}

protocol ListsMainViewModelRoutingDelegate: class {
    func createList()
    func showBooksFromList(listViewModel: ListViewModel)
}

