//
//  ListDetailViewController.swift
//  PracticaIOS_Books
//
//  Created by Javier Martinez on 01/05/2021.
//

import UIKit
import EmptyDataSet_Swift


class ListDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, HomeCellDelegate, ListDetailViewModelDelegate, EmptyDataSetSource, EmptyDataSetDelegate {

    @IBOutlet weak var tableView: UITableView!
    let viewModel: ListDetailViewModel
    private let CELL_ID = String(describing: HomeCell.self)
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.viewModel.delegate = self

        self.tableView.register(UINib(nibName: CELL_ID , bundle: nil), forCellReuseIdentifier: CELL_ID)
        // Do any additional setup after loading the view.
        tableView.emptyDataSetSource = self
        tableView.emptyDataSetDelegate = self
        tableView.tableFooterView = UIView()
    }
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        self.viewModel.getBookLists()
    }
    
    init(viewModel: ListDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.viewModel.delegate = self
        title = "\(viewModel.listDetail.name ?? "List")"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.bookViewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: CELL_ID, for: indexPath) as! HomeCell
        cell.delegate = self
        let cellViewModel = viewModel.bookViewModels[indexPath.item]
        cell.viewModel = cellViewModel
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func title(forEmptyDataSet scrollView: UIScrollView) -> NSAttributedString? {
        return NSAttributedString(string: "This list is empty...")
    }
    
    func description(forEmptyDataSet scrollView: UIScrollView) -> NSAttributedString? {
        return NSAttributedString(string: "Add books to it and they will apear here.")
    }
    
    func clickBookEvent(_: HomeCell, homeCell: HomeCollectionCell) {
        if let vm = homeCell.viewModel {
            viewModel.bookDetailRouting(bookResult: vm.bookResult)
        }
    }
    
    func bookChanged(_: ListDetailViewModel) {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }

}
