//
//  AddToListViewModel.swift
//  PracticaIOS_Books
//
//  Created by Javier Martinez on 25/04/2021.
//

import Foundation


class AddToListViewModel: AddToListManagerDelegate {
     
    var listViewModels: [ListViewModel] = []
    let listManager: ListManager
    let bookManager: BookManager
    let userSession: User
    let bookResult: BookResult
    weak var delegate: AddToListViewModelDelegate?
    weak var routingDelegate: AddToListViewModelRoutingDelegate?
    
    init(bookManager: BookManager, listManager: ListManager, userSession: User, book: BookResult) {
        self.listManager = listManager
        self.bookManager = bookManager
        self.userSession = userSession
        self.bookResult = book
        self.listManager.delegateAddTo = self
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
    
    func manageBookInList(listViewModel: ListViewModel, isOn: Bool){
        if isOn == true {
            self.bookManager.createBook(book: bookResult, completionHandler: { book in
                self.listManager.addBookToList(name: listViewModel.list!.name!, book: book)
            })
        }else{
            self.bookManager.getBook(book: bookResult, completionHandler: { book in
                if let book = book {
                    self.listManager.removeBookFromList(name: listViewModel.list!.name!, book: book)
                }
            })
        }
    }
    
    // MARK: AddToListManagerDelegate functions
    
    func listsResult(_: ListManager, didListChange lists: [List]) {
        self.bookManager.getBook(book: bookResult, completionHandler: { book in
            self.listViewModels = []
            for item in lists {
                var check = false

                if let book = book, let books = item.books {
                    check = books.contains(book)
                }
                self.listViewModels.append(ListViewModel(list: item, active: check))
                
            }
            self.delegate?.updateList(self)
            
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
