//
//  HomeSideViewController.swift
//  PracticaIOS_Books
//
//  Created by Javier Martinez on 15/05/2021.
//

import UIKit

class HomeSideViewController: UIViewController {
    
    
    let viewModel: HomeSideViewModel

    init(viewModel: HomeSideViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        UIGraphicsBeginImageContext(self.view.frame.size)
            UIImage(named: "sideMenuPic")?.draw(in: self.view.bounds)
            let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
            UIGraphicsEndImageContext()
            self.view.backgroundColor = UIColor(patternImage: image)

        self.view.backgroundColor = UIColor(patternImage: image)

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    @IBAction func clickLogoutButton(_ sender: Any) {
        self.viewModel.userLogout()
    }
    
    @IBAction func clickProfileButton(_ sender: Any) {
        self.viewModel.userProfileRouting()
    }
    
    @IBAction func clickAboutButton(_ sender: Any) {
        self.viewModel.aboutRouting()
    }
    

}
