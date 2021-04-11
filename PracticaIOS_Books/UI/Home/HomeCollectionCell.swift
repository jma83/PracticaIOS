//
//  HomeCollectionCell.swift
//  PracticaIOS_Books
//
//  Created by Javier Martinez on 10/04/2021.
//

import UIKit

class HomeCollectionCell: UICollectionViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var bookImage: UIImageView!
    var image: UIImage?
    var viewModel: BookViewModel? {
        didSet {
            guard let viewModel = viewModel else {
                return
            }
            let image = bookImage?.image
            if  image == nil {
                titleLabel?.text = viewModel.book.title
                authorLabel?.text = viewModel.book.author
                let url = URL(string: viewModel.book.book_image!)
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
