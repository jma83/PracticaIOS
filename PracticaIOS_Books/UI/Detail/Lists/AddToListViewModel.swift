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
    let bookManager: BookManager
    let userSession: User
    let bookDetail: BookResult
    weak var delegate: AddToListViewModelDelegate?
    weak var routingDelegate: AddToListViewModelRoutingDelegate?
    
    init(bookManager: BookManager, listManager: ListManager, userSession: User, book: BookResult) {
        self.listManager = listManager
        self.bookManager = bookManager
        self.userSession = userSession
        self.bookDetail = book
        self.listManager.delegate = self
        //self.bookManager.addListDelegate*****
        self.retrieveLists()
        
    }
    
    func retrieveLists() {
        self.listManager.fetchAllByUser(user: userSession)
    }
    
    func createListRouting(){
        self.routingDelegate?.createList()
    }
    
    func closeListRouting() {
        self.routingDelegate?.closeAddToList()
    }
    
    func listsResult(_: ListManager, didListChange lists: [List]) {

        for item in lists {
            listViewModels.append(ListViewModel(list: item))
        }
        self.delegate?.updateList(self)
    }
    
    func addBookToList(listViewModel: ListViewModel){
        self.bookManager.createBook(book: bookDetail, completionHandler: { book in
            self.listManager.addBookToList(name: listViewModel.name, book: book)
        })
        
        
    }

}

protocol AddToListViewModelDelegate: class {
    func updateList(_: AddToListViewModel)
}

protocol AddToListViewModelRoutingDelegate: class {
    func closeAddToList()
    func createList()
}
