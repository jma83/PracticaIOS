//
//  ModalViewController.swift
//  PracticaIOS_Books
//
//  Created by Javier Martinez on 28/03/2021.
//

import UIKit

class ModalView {
    
    func showAlert(title: String, message: String) -> UIViewController{
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        
        return alert
    }


}
