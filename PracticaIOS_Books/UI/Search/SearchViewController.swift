//
//  SearchViewController.swift
//  PracticaIOS_Books
//
//  Created by Javier Martinez on 17/04/2021.
//

import UIKit

class SearchViewController: UIViewController, UISearchBarDelegate, HomeCellDelegate, SearchViewModelDelegate  {
    
    func searchBook(_: SearchViewModel, bookResult: BookResult) {
        //dd
    }
    
    
    func clickBookEvent(_: HomeCell, homeCell: HomeCollectionCell) {
        //onclick
    }
    
    
    func bookChanged(_: SearchViewModel) {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    let viewModel: SearchViewModel
    private let CELL_ID = String(describing: HomeCell.self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(UINib(nibName: CELL_ID , bundle: nil), forCellReuseIdentifier: CELL_ID)
        // Do any additional setup after loading the view.
    }
    
    init(viewModel: SearchViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.viewModel.delegate = self

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.count > 2 {
            viewModel.searchBook(text: searchText)
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
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
}
