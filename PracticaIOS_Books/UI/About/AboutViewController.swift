//
//  AboutViewController.swift
//  PracticaIOS_Books
//
//  Created by Javier Martinez on 15/05/2021.
//

import UIKit

class AboutViewController: UIViewController {

    let viewModel: AboutViewModel
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    init(viewModel: AboutViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        title = "About"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Close", style: .done, target: self, action: #selector(closeAboutEvent))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func closeAboutEvent(){
        self.viewModel.closeAboutRouting()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
