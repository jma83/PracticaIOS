//
//  CommentsViewController.swift
//  PracticaIOS_Books
//
//  Created by Javier Martinez on 15/04/2021.
//

import UIKit

class CommentsViewController: UIViewController,UITableViewDelegate,UITableViewDataSource, CommentsCellDelegate {

    @IBOutlet weak var tableView: UITableView!
    private let CELL_ID = String(describing: CommentsCell.self)
    private var viewModel: CommentsViewModel
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(UINib(nibName: CELL_ID, bundle: nil), forCellReuseIdentifier: CELL_ID)
        title = "Comments"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Close", style: .done, target: self, action: #selector(closeCommentsEvent))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addCommentEvent))
    }
    
    init(viewModel: CommentsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func closeCommentsEvent() {
        viewModel.closeListRouting()
    }
    
    @objc func addCommentEvent() {
        viewModel.addCommentRouting()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.commentViewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: CELL_ID, for: indexPath) as! CommentsCell
        cell.delegate = self
        let cellViewModel = viewModel.commentViewModels[indexPath.item]
        cell.viewModel = cellViewModel
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func clickDeleteEvent(_: CommentsCell, commentViewModel: CommentViewModel) {
        <#code#>
    }
}
