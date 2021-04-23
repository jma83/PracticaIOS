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
        self.viewModel.loadBook()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func bookDetail(_: DetailViewModel, book: BookResult) {
        //setinfo
        DispatchQueue.main.async { [self] in
            self.titleText.text = book.title
            self.authorText.text = book.author
            self.descriptionText.text = book.description
            if let imageURL = book.book_image {
                let url = URL(string: imageURL)
                self.downloadImage(from: url!)
            }
        }
    }
    
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    func downloadImage(from url: URL) {
        print("Download Started")
        getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            print(response?.suggestedFilename ?? url.lastPathComponent)
            print("Download Finished")
            DispatchQueue.main.async() { [weak self] in
                self?.image = UIImage(data: data)
                self?.bookImage.image = self?.image
            }
        }
    }

}
