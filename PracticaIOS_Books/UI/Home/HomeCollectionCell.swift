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
            if  viewModel.bookResult.title != titleLabel?.text {
                titleLabel?.text = viewModel.bookResult.title
                authorLabel?.text = viewModel.bookResult.author
                
                let url = URL(string: viewModel.bookResult.book_image ?? "")
                self.bookImage.sd_setImage(with: url, placeholderImage: UIImage(named: "placeholder.jpeg"))
            }
        }
    }
    
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }

}
