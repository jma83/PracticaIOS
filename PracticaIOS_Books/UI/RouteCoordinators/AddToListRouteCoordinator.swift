//
//  AddListRouteCoordinator.swift
//  PracticaIOS_Books
//
//  Created by Javier Martinez on 25/04/2021.
//

import UIKit

class AddToListRouteCoordinator: AddToListViewModelRoutingDelegate {
    private var navigationController: UINavigationController
    let bookManager: BookManager
    let userManager: UserManager
    let listManager: ListManager
    weak var delegate: AddToListRouteCoordinatorDelegate?
    
    var rootViewController: UIViewController {
        return navigationController
    }
     
    init(bookManager: BookManager, userManager: UserManager) {
        self.bookManager = bookManager
        self.userManager = userManager
        self.listManager = ListManager()
        let vm = AddToListViewModel(listManager: listManager, userManager: userManager)
        let vc = AddToListViewController(viewModel: vm)
        
        
        navigationController = UINavigationController(rootViewController: vc)
        vm.routingDelegate = self
    }
    
    func closeAddToList(){
        delegate?.closeAddToList()
    }
    
    func createList(){
        //TODO
    }
}

protocol AddToListRouteCoordinatorDelegate: class {
    func closeAddToList()
}
