//
//  ModalViewController.swift
//  PracticaIOS_Books
//
//  Created by Javier Martinez on 28/03/2021.
//

import UIKit

class ModalView {
    weak var delegate: ModalViewDelegate?
    weak var confirmDelegate: ModalViewConfirmDelegate?
    func showAlert(title: String, message: String) -> UIViewController{
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        
        return alert
    }
    
    func showConfirmDeleteAlert(title: String, message: String) -> UIViewController{
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: {(alert: UIAlertAction!) in
            self.confirmDeleteModal()
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler:{(alert: UIAlertAction!) in
            self.dismissConfirmModal()
        }))
        
        return alert
    }
    
    func dismiss(){
        delegate?.dismissModal(self)
    }
    
    func dismissConfirmModal(){
        confirmDelegate?.dismissConfirmModal(self)
    }
    
    func confirmDeleteModal(){
        confirmDelegate?.confirmDelete(self)
    }

}
protocol ModalViewDelegate: class {
    func dismissModal(_: ModalView)
}
protocol ModalViewConfirmDelegate: class {
    func dismissConfirmModal(_: ModalView)
    func confirmDelete(_: ModalView)
}
