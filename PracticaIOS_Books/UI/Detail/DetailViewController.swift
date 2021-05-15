//
//  DetailViewController.swift
//  PracticaIOS_Books
//
//  Created by Javier Martinez on 10/04/2021.
//

import UIKit

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
    var checkLikeBook: Bool = false
    
    
    init(viewModel: DetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.viewModel.delegate = self
        title = "Book Detail"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.viewModel.loadBook()
    }
    
    func bookDetailResult(_: DetailViewModel) {

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
            
            if let imageURL = book?.book_image {
                let url = URL(string: imageURL)
                self.downloadImage(from: url!)
            }
        }
    }
    
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    func downloadImage(from url: URL) {
        getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.image = UIImage(data: data)
                self?.bookImage.image = self?.image
            }
        }
    }

    @IBAction func clickCommentsButton(_ sender: Any) {
        self.viewModel.showCommentsRouting()
    }
    
    @IBAction func clickLikeButton(_ sender: Any) {
        if checkLikeBook == false {
            checkLikeBook = true
            self.viewModel.likeBook()
        }
    }
    
    @IBAction func clickAddListButton(_ sender: Any) {
        self.viewModel.addBookToListRouting()
    }

    func likeAddResult(_: DetailViewModel, checkLike: Bool) {
        if checkLike == true {
            likeButton.setImage(UIImage(systemName: "hand.thumbsup.fill"), for: .normal)
        }else{
            likeButton.setImage(UIImage(systemName: "hand.thumbsup"), for: .normal)
        }
        checkLikeBook = false

    }
    
    func likeCheckBook(_: DetailViewModel) {
        likeButton.setImage(UIImage(systemName: "hand.thumbsup.fill"), for: .normal)
    }
    
}
