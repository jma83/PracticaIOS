//
//  ModalViewController.swift
//  PracticaIOS_Books
//
//  Created by Javier Martinez on 28/03/2021.
//

import UIKit

class ModalViewController {
    
    func showAlert(title: String, message: String) -> UIViewController{
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: { action in
            print("salir")
        }))
        
        return alert
    }

}
