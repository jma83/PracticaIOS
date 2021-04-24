//
//  SearchRouteCoordinator.swift
//  PracticaIOS_Books
//
//  Created by Javier Martinez on 19/04/2021.
//

import UIKit

class SearchRouteCoordinator: SearchViewModelRoutingDelegate, DetailViewModelRoutingDelegate, CommentsViewModelRoutingDelegate {

    private var navigationController: UINavigationController
    let bookManager: BookManager
    var rootViewController: UIViewController {
        return navigationController
    }

    
    init(bookManager:BookManager) {
        self.bookManager = bookManager
        let searchViewModel = SearchViewModel(bookManager: bookManager)
        let searchViewController = SearchViewController(viewModel: searchViewModel)
        
        navigationController = UINavigationController(rootViewController: searchViewController)
        searchViewModel.routingDelegate = self
    }
    
    // CommentsViewModelRoutingDelegate: From Comments to AddComment
    func addComment(_: CommentsViewModel) {
        //TODO
    }
    
    // CommentsViewModelRoutingDelegate: From Comments to CommentDetail
    func showCommentDetail(_: CommentsViewModel) {
        //TODO
    }
    
    // DetailViewModelRoutingDelegate: From Detail to Lists
    //Redirect to New RouteCoordinator! -> AddToExistingList (Modal)
    func showAddList(book: BookResult) {
        //TODO
    }
    
    // DetailViewModelRoutingDelegate: From Detail to Comments
    func showCommentsView(book: BookResult) {
        let vm = CommentsViewModel(bookManager: bookManager)
        vm.routingDelegate = self
        let vc2: CommentsViewController = CommentsViewController(viewModel: vm)
        navigationController.pushViewController(vc2, animated: true)
    }
    
    // SearchViewModelRoutingDelegate: From Search to Detail
    func watchDetail(book: BookResult) {
        let vm = DetailViewModel(bookManager: bookManager, bookResult: book)
        vm.routingDelegate = self
        let vc: DetailViewController = DetailViewController(viewModel: vm)
        navigationController.pushViewController(vc, animated: true)
    }

}
