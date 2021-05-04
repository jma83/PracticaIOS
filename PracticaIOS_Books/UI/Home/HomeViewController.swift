//
//  HomeViewController.swift
//  PracticaIOS_Books
//
//  Created by Javier Martinez on 03/04/2021.
//

import UIKit

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, HomeViewModelDelegate, HomeCellDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    private let CELL_ID = String(describing: HomeCell.self)
    let viewModel: HomeViewModel
    @IBOutlet weak var trailingMenu: NSLayoutConstraint!
    @IBOutlet weak var leadingMenu: NSLayoutConstraint!
    
    private var menuActive = false
    
    
    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.viewModel.delegate = self
        self.viewModel.getHomeBooks()
        title = "Home"

    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(UINib(nibName: CELL_ID, bundle: nil), forCellReuseIdentifier: CELL_ID)
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Menu", style: .done, target: self, action: #selector(clickMenuButton))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Reload", style: .done, target: self, action: #selector(clickNewBooks))
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.viewModel.sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = self.tableView.dequeueReusableCell(withIdentifier: CELL_ID, for: indexPath) as! HomeCell
        cell.delegate = self
        let cellViewModel = viewModel.bookViewModels[indexPath.section]
        cell.viewModel = cellViewModel
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.viewModel.sections[section]
    }
    
    func bookChanged(_: HomeViewModel) {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    

    @objc func clickMenuButton(_ sender: Any) {
        if !menuActive {
            leadingMenu.constant = 150
            trailingMenu.constant = -150
        }else{
            leadingMenu.constant = 0
            leadingMenu.constant = 0
        }
        menuActive = !menuActive
        
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseIn, animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
        
    }
    
    @objc func clickNewBooks(_ sender: Any) {
        viewModel.getHomeBooks()
        
    }
    
    func clickBookEvent(_: HomeCell, homeCell: HomeCollectionCell) {
        if let vm = homeCell.viewModel {
            viewModel.bookDetailRouting(bookResult: vm.bookResult)
        }
    }

}
