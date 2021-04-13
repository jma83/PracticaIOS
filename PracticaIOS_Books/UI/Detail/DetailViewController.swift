//
//  DetailViewController.swift
//  PracticaIOS_Books
//
//  Created by Javier Martinez on 10/04/2021.
//

import UIKit

class DetailViewController:  UIViewController, DetailViewModelDelegate {
    func bookDetail(_: DetailViewModel, book: BookResult) {
        //setinfo
    }
    

    @IBOutlet weak var bookImage: UIImageView!
    
    @IBOutlet weak var titleText: UILabel!
    @IBOutlet weak var authorText: UILabel!
    @IBOutlet weak var descriptionText: UILabel!
    
    var image: UIImage?
    var isnb: String?
    var viewModel: BookViewModel?
    

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleText.text = viewModel?.book.title
        authorText.text = viewModel?.book.author
        descriptionText.text = viewModel?.book.description
        bookImage.image = image
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
