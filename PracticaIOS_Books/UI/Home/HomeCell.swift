//
//  HomeCell.swift
//  PracticaIOS_Books
//
//  Created by Javier Martinez on 03/04/2021.
//

import UIKit

class HomeCell: UITableViewCell {
    
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    var viewModel: BookViewModel? {
        didSet {
            guard let viewModel = viewModel else {
                return
            }
            textLabel?.text = viewModel.title
            detailTextLabel?.text = viewModel.author
            //titleLabel?.text = viewModel.title
            //authorLabel?.text = viewModel.author
        }
    }
    
}

