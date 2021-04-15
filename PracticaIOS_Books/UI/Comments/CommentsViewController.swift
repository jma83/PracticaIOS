//
//  CommentsViewController.swift
//  PracticaIOS_Books
//
//  Created by Javier Martinez on 15/04/2021.
//

import UIKit

class CommentsViewController: UIViewController {
    
    private var viewModel: CommentsViewModel
    
    override func viewDidLoad() {
        
    }
    
    init(viewModel: CommentsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
