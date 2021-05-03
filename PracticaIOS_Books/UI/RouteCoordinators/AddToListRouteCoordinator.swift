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
    let userManager: UserManager
    let listManager: ListManager
    weak var delegate: AddToListRouteCoordinatorDelegate?
    
    var rootViewController: UIViewController {
        return navigationController
    }
     
    init(bookManager: BookManager, userManager: UserManager, listManager: ListManager) {
        self.bookManager = bookManager
        self.userManager = userManager
        self.listManager = listManager
        let vm = AddToListViewModel(listManager: listManager, userManager: userManager)
        let vc = AddToListViewController(viewModel: vm)
        
        
        navigationController = UINavigationController(rootViewController: vc)
        vm.routingDelegate = self
    }
    
    func closeAddToList(){
        delegate?.closeAddToList()
    }
    
    func createList(){
        let vm = CreateListViewModel(listManager: listManager, userManager: userManager)
        vm.routingDelegate = self
        let vc = CreateListViewController(viewModel: vm)
        navigationController.pushViewController(vc, animated: true)
    }
    
    func createListResult(){
        //TODO
        //pop and update
        navigationController.popViewController(animated: true)
    }
    
}

protocol AddToListRouteCoordinatorDelegate: class {
    func closeAddToList()
}
