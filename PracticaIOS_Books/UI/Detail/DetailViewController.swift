//
//  DetailViewController.swift
//  PracticaIOS_Books
//
//  Created by Javier Martinez on 10/04/2021.
//

import UIKit
import SVProgressHUD
import SDWebImage


class DetailViewController:  UIViewController, DetailViewModelDelegate {

    @IBOutlet weak var bookImage: UIImageView!
    
    @IBOutlet weak var titleText: UILabel!
    @IBOutlet weak var authorText: UILabel!
    @IBOutlet weak var descriptionText: UILabel!
    @IBOutlet weak var dateText: UILabel!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var myListButton: UIButton!
    @IBOutlet weak var commentsButton: UIButton!
    
    var image: UIImage?
    var isnb: String?
    var viewModel: DetailViewModel
    
    
    init(viewModel: DetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.viewModel.delegate = self
        title = "Book Detail"
        SVProgressHUD.show()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.viewModel.loadBook()
    }
    
    func bookDetailResult(_: DetailViewModel) {
        SVProgressHUD.dismiss()
        let book = self.viewModel.bookViewModel?.bookResult
        DispatchQueue.main.async {
            if let title = book?.title {
                self.titleText.text = "Title: \(title)"
            }
            
            if let author = book?.author {
                self.authorText.text = "Author: \(author)"
            }
            
            if let date = book?.created_date {
                self.dateText.text = "Publish date: \(date)"
            }
            
            if let descrip = book?.description{
                self.descriptionText.text = descrip
            }
            
            let url = URL(string: book?.book_image ?? "")
            self.bookImage.sd_setImage(with: url, placeholderImage: UIImage(named: "placeholder.jpeg"))
            
        }
    }
    
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }

    @IBAction func clickCommentsButton(_ sender: Any) {
        self.viewModel.showCommentsRouting()
    }
    
    @IBAction func clickLikeButton(_ sender: Any) {
        self.viewModel.likeBook()
    }
    
    @IBAction func clickAddListButton(_ sender: Any) {
        self.viewModel.addBookToListRouting()
    }

    func likeAddResult(_: DetailViewModel, checkLike: Bool) {
        checkLikedBook(checkLike: checkLike)
    }
    
    func likeCheckBook(_: DetailViewModel, checkLike: Bool) {
        checkLikedBook(checkLike: checkLike)
    }
    
    func checkLikedBook(checkLike: Bool) {
        if checkLike == true {
            likeButton.setImage(UIImage(systemName: "hand.thumbsup.fill"), for: .normal)
        }else{
            likeButton.setImage(UIImage(systemName: "hand.thumbsup"), for: .normal)
        }
    }
    
}
