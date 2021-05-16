//
//  SearchViewController.swift
//  PracticaIOS_Books
//
//  Created by Javier Martinez on 17/04/2021.
//

import UIKit
import EmptyDataSet_Swift

class SearchViewController: UIViewController, UISearchBarDelegate, HomeCellDelegate, SearchViewModelDelegate, EmptyDataSetSource, EmptyDataSetDelegate  {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    let viewModel: SearchViewModel
    private let CELL_ID = String(describing: HomeCell.self)
    private var result = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardEvent()

        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.searchBar.delegate = self
        self.viewModel.delegate = self

        self.tableView.register(UINib(nibName: CELL_ID , bundle: nil), forCellReuseIdentifier: CELL_ID)
        self.tableView.emptyDataSetSource = self
        self.tableView.emptyDataSetDelegate = self
        self.tableView.tableFooterView = UIView()
    }
    
    init(viewModel: SearchViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.viewModel.delegate = self
        title = "Search"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let text = searchBar.text
        if let text = text {
            if text.count > 2 && result {
                result = false
                viewModel.searchBook(text: text)
            }
        }
        self.searchBar.endEditing(true)

    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        viewModel.resetAndShow()
    }
    
    
    func searchResult(_: SearchViewModel) {
        result = true
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    func bookChanged(_: SearchViewModel) {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
        
    func clickBookEvent(_: HomeCell, homeCell: HomeCollectionCell) {
        if let vm = homeCell.viewModel {
            viewModel.bookDetailRouting(bookResult: vm.bookResult)
        }
    }

}

extension SearchViewController:  UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return viewModel.bookViewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: CELL_ID, for: indexPath) as! HomeCell
        cell.delegate = self
        let cellViewModel = viewModel.bookViewModels[indexPath.item]
        cell.viewModel = cellViewModel
        
        let vm = viewModel.bookViewModels[0]
        if vm.count == 0 {
            cell.textLabel?.text = "No books found..."
            cell.detailTextLabel?.text = "Please, try again with other words"
        }else{
            cell.textLabel?.text = ""
            cell.detailTextLabel?.text = ""
        }
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func title(forEmptyDataSet scrollView: UIScrollView) -> NSAttributedString? {
        return NSAttributedString(string: "Search is empty")
    }
    
    func description(forEmptyDataSet scrollView: UIScrollView) -> NSAttributedString? {
        return NSAttributedString(string: "Try with any book title, author...")
    }
    
    
}
