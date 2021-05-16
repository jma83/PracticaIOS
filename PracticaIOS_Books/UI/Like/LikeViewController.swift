//
//  LikeViewController.swift
//  PracticaIOS_Books
//
//  Created by Javier Martinez on 29/04/2021.
//

import UIKit
import EmptyDataSet_Swift


class LikeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, EmptyDataSetSource, EmptyDataSetDelegate, HomeCellDelegate, LikeViewModelDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    private let CELL_ID = String(describing: HomeCell.self)
    let viewModel: LikeViewModel
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(UINib(nibName: CELL_ID, bundle: nil), forCellReuseIdentifier: CELL_ID)
        self.tableView.emptyDataSetSource = self
        self.tableView.emptyDataSetDelegate = self
        self.tableView.tableFooterView = UIView()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.viewModel.getLikedBooks()
    }
    
    
    init(viewModel: LikeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.viewModel.delegate = self
        title = "Likes"
    }
    
    func bookChanged(_: LikeViewModel) {
        DispatchQueue.main.async {
            self.tableView?.reloadData()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.bookViewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: CELL_ID, for: indexPath) as! HomeCell
        cell.delegate = self
        let cellViewModel = viewModel.bookViewModels[indexPath.item]
        cell.viewModel = cellViewModel
        let vm = viewModel.bookViewModels[0]
        if vm.count == 0 {
            cell.textLabel?.text = "No books yet..."
            cell.detailTextLabel?.text = "Find some books you like. They will apear here"
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
        return NSAttributedString(string: "Your like list is empty...")
    }
    
    func description(forEmptyDataSet scrollView: UIScrollView) -> NSAttributedString? {
        return NSAttributedString(string: "Add some books you like. They will appear here.")
    }
    
    func clickBookEvent(_: HomeCell, homeCell: HomeCollectionCell) {
        if let vm = homeCell.viewModel {
            self.viewModel.bookDetailRouting(bookResult: vm.bookResult)
        }
    }
    

}
