//
//  AddListRouteCoordinator.swift
//  PracticaIOS_Books
//
//  Created by Javier Martinez on 25/04/2021.
//

import UIKit

class AddToListRouteCoordinator: AddToListViewModelRoutingDelegate, CreateListViewModelRoutingDelegate {
    private var navigationController: UINavigationController
    let bookManager: BookManager
    let userSession: User
    let listManager: ListManager
    weak var delegate: AddToListRouteCoordinatorDelegate?
    
    var rootViewController: UIViewController {
        return navigationController
    }
     
    init(bookManager: BookManager, listManager: ListManager, userSession: User, book: BookResult) {
        self.bookManager = bookManager
        self.userSession = userSession
        self.listManager = listManager
        let vm = AddToListViewModel(bookManager: bookManager, listManager: listManager, userSession: userSession, book: book)
        let vc = AddToListViewController(viewModel: vm)
        
        
        navigationController = UINavigationController(rootViewController: vc)
        vm.routingDelegate = self
    }
    
    func closeAddToList(){
        delegate?.closeAddToList()
    }
    
    func createList(){
        let vm = CreateListViewModel(listManager: listManager, userSession: userSession)
        vm.routingDelegate = self
        let vc = CreateListViewController(viewModel: vm)
        navigationController.pushViewController(vc, animated: true)
    }
    
    func createListResult(){
        navigationController.popViewController(animated: true)
    }
    
}

protocol AddToListRouteCoordinatorDelegate: class {
    func closeAddToList()
}
