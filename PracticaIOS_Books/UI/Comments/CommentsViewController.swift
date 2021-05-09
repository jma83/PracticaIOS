//
//  CommentsViewController.swift
//  PracticaIOS_Books
//
//  Created by Javier Martinez on 15/04/2021.
//

import UIKit

class CommentsViewController: UIViewController,UITableViewDelegate,UITableViewDataSource, CommentsCellDelegate, CommentsViewModelDelegate {

    @IBOutlet weak var tableView: UITableView!
    private let CELL_ID = String(describing: CommentsCell.self)
    private var viewModel: CommentsViewModel
    var deleteCommentVM: CommentViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(UINib(nibName: CELL_ID, bundle: nil), forCellReuseIdentifier: CELL_ID)
        title = "Comments"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Close", style: .done, target: self, action: #selector(closeCommentsEvent))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addCommentEvent))
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.viewModel.getBookComments()
    }
    
    init(viewModel: CommentsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.viewModel.delegate = self
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
        deleteCommentVM = commentViewModel
        present(self.showConfirmDeleteAlert(title:  "Delete comment", message: "Do you want to delete this comment?" ), animated: true)
    }
    
    func updateList(_: CommentsViewModel) {
        DispatchQueue.main.async {
            self.tableView?.reloadData()
        }
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
        if let deleteCommentVM = deleteCommentVM {
            self.viewModel.commentDelete(commentViewModel: deleteCommentVM)
        }
    }
    
    func cancelDeleteEvent(){
        self.deleteCommentVM = nil
    }
    
}
