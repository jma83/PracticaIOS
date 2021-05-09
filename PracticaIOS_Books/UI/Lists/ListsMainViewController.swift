//
//  ListsMainViewController.swift
//  PracticaIOS_Books
//
//  Created by Javier Martinez on 01/05/2021.
//

import UIKit

class ListsMainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, ListMainTableViewCellDelegate, ListsMainViewModelDelegate {
 
    @IBOutlet weak var tableView: UITableView!
    private let CELL_ID = String(describing: ListMainTableViewCell.self)
    let viewModel:ListsMainViewModel
    var checkRouting: Bool = true
    var deleteListViewModel: ListViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(UINib(nibName: CELL_ID, bundle: nil), forCellReuseIdentifier: CELL_ID)
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(createListEvent))
    }
    
    override func viewDidAppear(_ animated: Bool){
        checkRouting = false
        self.viewModel.retrieveLists()
    }
    
    init(viewModel: ListsMainViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.viewModel.delegate = self
        title = "My lists"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.listViewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: CELL_ID, for: indexPath) as! ListMainTableViewCell
        cell.delegate = self
        let cellViewModel = viewModel.listViewModels[indexPath.item]
        cell.viewModel = cellViewModel
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func updateList(_: ListsMainViewModel) {
        DispatchQueue.main.async {
            self.tableView?.reloadData()
        }
    }
    
    func deleteListResult(_: ListsMainViewModel) {
        self.viewModel.retrieveLists()
    }
    
    func clickListEvent(_: ListMainTableViewCell, listViewModel: ListViewModel) {
        if self.checkRouting == false {
            self.checkRouting = true
            self.viewModel.showListRouting(listViewModel: listViewModel)
        }

    }
    
    @objc func createListEvent(){
        self.viewModel.createListRouting()
    }
    
    func clickDeleteEvent(_: ListMainTableViewCell, listViewModel: ListViewModel) {
        self.deleteListViewModel = listViewModel
        present(self.showConfirmDeleteAlert(title:  "Delete list", message: "Do you want to delete the list \(listViewModel.name)" ), animated: true)
    }
    
    func showConfirmDeleteAlert(title: String, message: String) -> UIViewController{
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: {(alert: UIAlertAction!) in
            self.confirmDeleteEvent()
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler:{(alert: UIAlertAction!) in
            self.cancelDeleteEvent()
        }))
        
        return alert
    }
    
    func confirmDeleteEvent(){
        if let deleteListViewModel = deleteListViewModel {
            self.viewModel.deleteList(listViewModel: deleteListViewModel)
        }
    }
    
    func cancelDeleteEvent(){
        self.deleteListViewModel = nil
    }
}
