//
//  AddToListViewController.swift
//  PracticaIOS_Books
//
//  Created by Javier Martinez on 25/04/2021.
//

import UIKit

class AddToListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, AddToListViewModelDelegate, ListTableViewCellDelegate {
   
    @IBOutlet weak var tableView: UITableView!
    private let CELL_ID = String(describing: ListTableViewCell.self)
    let viewModel: AddToListViewModel
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(UINib(nibName: CELL_ID, bundle: nil), forCellReuseIdentifier: CELL_ID)
        title = "Add book to list"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Close", style: .done, target: self, action: #selector(closeAddListEvent))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(createListEvent))
    }
    
    override func viewDidAppear(_ animated: Bool){
        self.viewModel.retrieveLists()
    }
    
    init(viewModel: AddToListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.viewModel.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.listViewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: CELL_ID, for: indexPath) as! ListTableViewCell
        cell.delegate = self
        let cellViewModel = viewModel.listViewModels[indexPath.item]
        cell.viewModel = cellViewModel
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func updateList(_: AddToListViewModel) {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func toggleListEvent(_: ListTableViewCell, listViewModel: ListViewModel, isOn: Bool) {
        
        self.viewModel.manageBookInList(listViewModel: listViewModel, isOn: isOn)
    }
    
    @objc func closeAddListEvent(){
        self.viewModel.closeListRouting()
    }
    
    @objc func createListEvent(){
        self.viewModel.createListRouting()
    }

}
