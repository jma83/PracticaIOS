//
//  ListsMainViewController.swift
//  PracticaIOS_Books
//
//  Created by Javier Martinez on 01/05/2021.
//

import UIKit
import EmptyDataSet_Swift

class ListsMainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, ListMainTableViewCellDelegate, ListsMainViewModelDelegate, EmptyDataSetSource, EmptyDataSetDelegate {
 
    @IBOutlet weak var tableView: UITableView!
    private let CELL_ID = String(describing: ListMainTableViewCell.self)
    let viewModel:ListsMainViewModel
    var checkRouting: Bool = true

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(UINib(nibName: CELL_ID, bundle: nil), forCellReuseIdentifier: CELL_ID)
        tableView.emptyDataSetSource = self
        tableView.emptyDataSetDelegate = self
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(createListEvent))
        tableView.tableFooterView = UIView()
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
    
    func title(forEmptyDataSet scrollView: UIScrollView) -> NSAttributedString? {
        return NSAttributedString(string: "You don't have any list yet...")
    }
    
    func description(forEmptyDataSet scrollView: UIScrollView) -> NSAttributedString? {
        return NSAttributedString(string: "Create one now and start adding books to it.")
    }
    
    func updateList(_: ListsMainViewModel) {
        DispatchQueue.main.async {
            self.tableView?.reloadData()
        }
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
        self.viewModel.showConfirmDeleteModal(listViewModel: listViewModel)
    }
    
}
