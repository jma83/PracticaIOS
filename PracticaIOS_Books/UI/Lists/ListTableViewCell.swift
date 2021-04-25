//
//  ListTableViewCell.swift
//  PracticaIOS_Books
//
//  Created by Javier Martinez on 25/04/2021.
//

import UIKit

class ListTableViewCell: UITableViewCell {

    @IBOutlet weak var nameListText: UILabel!
    @IBOutlet weak var dateListText: UILabel!
    @IBOutlet weak var switchList: UISwitch!
    weak var delegate: ListTableViewCellDelegate?
    
    var viewModel: ListViewModel? {
        didSet {
            if viewModel != nil {
                self.nameListText.text = viewModel?.name
                let formatter1 = DateFormatter()
                formatter1.dateStyle = .long
                let dateStr = formatter1.string(from: viewModel!.date)
                self.dateListText.text = dateStr
            }
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func toggleSwitch(_ sender: Any) {
        
    }
    
    
}

protocol ListTableViewCellDelegate: class {
    func clickListEvent(_: ListTableViewCell, listViewModel: ListViewModel)
}

