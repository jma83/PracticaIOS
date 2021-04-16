//
//  HomeViewController.swift
//  PracticaIOS_Books
//
//  Created by Javier Martinez on 03/04/2021.
//

import UIKit

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, HomeViewModelDelegate, HomeCellDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    private let CELL_ID = "HomeCell"
    let viewModel: HomeViewModel
    @IBOutlet weak var trailingMenu: NSLayoutConstraint!
    @IBOutlet weak var leadingMenu: NSLayoutConstraint!
    let sections = ["Libros relevantes", "Novedades", "Mis listas"]
    
    private var menuActive = false
    
    
    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.viewModel.delegate = self
        
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(UINib(nibName: String(describing: HomeCell.self) , bundle: nil), forCellReuseIdentifier: CELL_ID)
        //self.tableView.register(HomeCell.self, forCellReuseIdentifier: CELL_ID)
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Menu", style: .done, target: self, action: #selector(clickMenuButton))
        
        title = "Home"
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
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
        return sections[section]
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
    
    func clickBookEvent(_: HomeCell, homeCell: HomeCollectionCell) {
        viewModel.bookDetail(bookResult: homeCell.viewModel!.book)
        /*collectionCellEvent=homeCell
        performSegue(withIdentifier: "homeToDetail", sender: self)*/
    }

}
