//
//  ModalViewController.swift
//  PracticaIOS_Books
//
//  Created by Javier Martinez on 28/03/2021.
//

import UIKit

class ModalView {
    weak var delegate: ModalViewDelegate?
    func showAlert(title: String, message: String) -> UIViewController{
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        
        return alert
    }
    
    func dismiss(){
        delegate?.dismissModal(self)
    }


}
protocol ModalViewDelegate: class {
    func dismissModal(_: ModalView)
}
