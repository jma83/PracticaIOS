//
//  AddToListViewModel.swift
//  PracticaIOS_Books
//
//  Created by Javier Martinez on 25/04/2021.
//

import Foundation


class AddToListViewModel: ListManagerDelegate {
    
    var listViewModels: [ListViewModel] = []
    let listManager: ListManager
    let userManager: UserManager
    weak var delegate: AddToListViewModelDelegate?
    weak var routingDelegate: AddToListViewModelRoutingDelegate?
    
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
    
    func createListRouting(){
        self.routingDelegate?.createList()
    }
    
    func closeListRouting() {
        self.routingDelegate?.closeAddToList()
    }
    
    func listsResult(_: ListManager, didListChange list: [List]) {
        //TODO
        //Event recieved from
    }
    
    func addBookToList(listViewModel: ListViewModel){
        //TODO
        // call listManagerMethod or bookManager to add book to selected list
        
        
    }
    
    
    
}

protocol AddToListViewModelDelegate: class {
    func updateList(_: AddToListViewModel)
}

protocol AddToListViewModelRoutingDelegate: class {
    func closeAddToList()
    func createList()
}
