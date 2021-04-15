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
    var viewModel: DetailViewModel?
    
    
    init(viewModel: DetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleText.text = viewModel?.bookViewModel?.title
        authorText.text = viewModel?.bookViewModel?.author
        descriptionText.text = viewModel?.bookViewModel?.description
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
