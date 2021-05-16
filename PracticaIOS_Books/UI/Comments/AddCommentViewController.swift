//
//  AddCommentViewController.swift
//  PracticaIOS_Books
//
//  Created by Javier Martinez on 15/04/2021.
//

import UIKit

class AddCommentViewController: UIViewController, UITextViewDelegate, UITextFieldDelegate {
    
    

    @IBOutlet weak var titleText: UITextField!
    @IBOutlet weak var descriptionText: UITextView!
    @IBOutlet weak var submitButton: UIButton!
    let viewModel: AddCommentViewModel

    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardEvent()
        titleText.delegate = self
        descriptionText.delegate = self

    }
    @IBAction func postComment(_ sender: Any) {
        let name = titleText.text ?? ""
        let desc = descriptionText.text ?? ""
        
        self.viewModel.createComment(summary: name, descrip: desc)
    }
    
    init(viewModel: AddCommentViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc public func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if(text == "\n") {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
}
