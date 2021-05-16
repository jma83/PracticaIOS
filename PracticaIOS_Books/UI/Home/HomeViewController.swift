//
//  HomeViewController.swift
//  PracticaIOS_Books
//
//  Created by Javier Martinez on 03/04/2021.
//

import UIKit
import SVProgressHUD
import EmptyDataSet_Swift

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, HomeViewModelDelegate, HomeCellDelegate, EmptyDataSetSource, EmptyDataSetDelegate {
    
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
        title = "Home"
        self.viewModel.getHomeBooks()

    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SVProgressHUD.show()

        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(UINib(nibName: CELL_ID, bundle: nil), forCellReuseIdentifier: CELL_ID)
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Menu", style: .done, target: self, action: #selector(clickMenuButton))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(clickNewBooks))
        self.tableView.emptyDataSetSource = self
        self.tableView.emptyDataSetDelegate = self
        self.tableView.tableFooterView = UIView()
    }
    
    @objc func clickMenuButton(_ sender: Any) {
        viewModel.showSideMenu()
    }
    
    @objc func clickNewBooks(_ sender: Any) {
        viewModel.getHomeBooks()
    }
    
    // MARK: UITableViewDelegate functions
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if self.viewModel.sections.count > 0 {
            SVProgressHUD.dismiss()
        }
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
    
    func title(forEmptyDataSet scrollView: UIScrollView) -> NSAttributedString? {
        return NSAttributedString(string: "Loading results...")
    }
    
    func spaceHeight(forEmptyDataSet scrollView: UIScrollView) -> CGFloat {
        return 2
    }
    
    func description(forEmptyDataSet scrollView: UIScrollView) -> NSAttributedString? {
        return NSAttributedString(string: "Please, try refreshing if nothing happens")
    }
        
    // MARK: HomeViewModelDelegate functions
    
    func bookChanged(_: HomeViewModel) {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    // MARK: HomeCellDelegate functions
    
    func clickBookEvent(_: HomeCell, homeCell: HomeCollectionCell) {
        if let vm = homeCell.viewModel {
            viewModel.bookDetailRouting(bookResult: vm.bookResult)
        }
    }

}
