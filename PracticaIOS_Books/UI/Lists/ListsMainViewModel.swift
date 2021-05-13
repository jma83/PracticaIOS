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
    var deleteListViewModel: ListViewModel?
    var userSession: User
    weak var delegate: ListsMainViewModelDelegate?
    weak var routingDelegate: ListsMainViewModelRoutingDelegate?
    init(listManager: ListManager, userSession: User) {
        self.listManager = listManager
        self.userSession = userSession
        self.listManager.delegate = self
    }
    
    func retrieveLists() {
        self.listManager.fetchAllByUser(user: userSession)
    }
    
    
    func listsResult(_: ListManager, didListChange lists: [List]) {
        self.listViewModels = []
        for item in lists {
            self.listViewModels.append(ListViewModel(list: item))
            
        }
        self.delegate?.updateList(self)
    }
    
    func deleteListResult(_: ListManager) {
        self.retrieveLists()
    }
    
    func createListRouting(){
        self.routingDelegate?.createList(self, userSession: userSession)
    }
    
    func showListRouting(listViewModel: ListViewModel){
        self.routingDelegate?.showBooksFromList(self, listViewModel: listViewModel, userSession: userSession)
    }
    
    func showConfirmDeleteModal(listViewModel: ListViewModel) {
        deleteListViewModel = listViewModel
        self.routingDelegate?.showConfirmDeleteModal(title: "Delete list", message: "Do you want to delete the list \(listViewModel.name)")
    }

    func confirmDeleteEvent(){
        if let deleteListViewModel = deleteListViewModel {
            self.listManager.deleteList(list: deleteListViewModel.list, user: userSession)
        }
    }
    
    func cancelDeleteEvent(){
        self.deleteListViewModel = nil
    }
}


protocol ListsMainViewModelDelegate: class {
    func updateList(_: ListsMainViewModel)
}

protocol ListsMainViewModelRoutingDelegate: class {
    func createList(_: ListsMainViewModel, userSession: User)
    func showBooksFromList(_: ListsMainViewModel, listViewModel: ListViewModel, userSession: User)
    func showConfirmDeleteModal(title: String, message: String)
}

