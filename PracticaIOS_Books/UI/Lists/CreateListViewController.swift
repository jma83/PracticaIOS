//
//  CreateListViewController.swift
//  PracticaIOS_Books
//
//  Created by Javier Martinez on 25/04/2021.
//

import UIKit

class CreateListViewController: UIViewController, UITextFieldDelegate {
    

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var createListButton: UIButton!
    
    let viewModel: CreateListViewModel
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardEvent()
        nameTextField.delegate = self
    }

    @IBAction func clickCreateButton(_ sender: Any) {
        if let name = nameTextField.text {
            self.viewModel.createList(listName: name)
        }
    }
    
    init(viewModel: CreateListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}
