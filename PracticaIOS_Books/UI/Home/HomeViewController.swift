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
    var collectionCellEvent: HomeCollectionCell?
    
    private var menuActive = false
    
    
    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.viewModel.delegate = self
        
    }
    
    required init?(coder: NSCoder) {
        self.viewModel = HomeViewModel(bookManager: BookManager())
        super.init(coder: coder)
        self.viewModel.delegate = self
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("Count numberOfRowsInSection: \(viewModel.bookViewModels.count)")
        /*if viewModel.bookViewModels[section].isEmpty{
            return 0
        }*/
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
    
    func bookChanged(_: BookManager) {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }

    @IBAction func clickMenuButton(_ sender: Any) {
        if !menuActive {
            leadingMenu.constant = 150
            trailingMenu.constant = -150
            menuActive = true
        }else{
            leadingMenu.constant = 0
            leadingMenu.constant = 0
            menuActive = false
        }
        
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseIn, animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
        
    }
    
    func clickBookEvent(_: HomeCell, homeCell: HomeCollectionCell) {
        collectionCellEvent=homeCell
        performSegue(withIdentifier: "homeToDetail", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let dvc = segue.destination as? DetailViewController {
            dvc.author = self.collectionCellEvent?.authorLabel.text ?? ""
            dvc.titleT = self.collectionCellEvent?.titleLabel.text ?? ""
            dvc.image = self.collectionCellEvent?.bookImage.image ?? UIImage()
            dvc.descripT = self.collectionCellEvent?.viewModel?.description ?? ""
        }
    }

}
