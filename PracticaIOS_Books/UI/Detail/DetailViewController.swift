//
//  DetailViewController.swift
//  PracticaIOS_Books
//
//  Created by Javier Martinez on 10/04/2021.
//

import UIKit

class DetailViewController:  UIViewController {

    @IBOutlet weak var bookImage: UIImageView!
    
    @IBOutlet weak var titleText: UILabel!
    @IBOutlet weak var authorText: UILabel!
    @IBOutlet weak var descriptionText: UILabel!
    
    var image: UIImage = UIImage()
    var titleT: String = ""
    var author: String = ""
    var descripT: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleText.text = titleT
        authorText.text = author
        descriptionText.text = descripT
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
