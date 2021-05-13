//
//  AddListRouteCoordinator.swift
//  PracticaIOS_Books
//
//  Created by Javier Martinez on 25/04/2021.
//

import UIKit

class AddToListRouteCoordinator: AddToListViewModelRoutingDelegate, CreateListViewModelRoutingDelegate, ModalViewDelegate {
    
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
    
    func createListResult(_: CreateListViewModel) {
        navigationController.popViewController(animated: true)
    }
    
    func showInfoModal(title: String, message: String) {
        let modal = ModalView()
        modal.delegate = self
        rootViewController.present(modal.showAlert(title: title, message: message), animated: true)
    }
    
    func dismissModal(_: ModalView) {
        rootViewController.dismiss(animated: true, completion: nil)
    }
    
}

protocol AddToListRouteCoordinatorDelegate: class {
    func closeAddToList()
}
