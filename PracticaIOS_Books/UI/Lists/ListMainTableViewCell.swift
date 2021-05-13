//
//  ListMainTableViewCell.swift
//  PracticaIOS_Books
//
//  Created by Javier Martinez on 02/05/2021.
//

import UIKit

class ListMainTableViewCell: UITableViewCell {

    weak var delegate: ListMainTableViewCellDelegate?
    
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var nameListText: UILabel!
    @IBOutlet weak var dateListText: UILabel!
    var viewModel: ListViewModel? {
        didSet {
            if viewModel != nil {
                self.nameListText.text = viewModel?.list?.name ?? ""
                let formatter1 = DateFormatter()
                formatter1.dateStyle = .long
                var dateStr = ""
                if let date = viewModel?.list?.updateDate {
                    dateStr = formatter1.string(from: date)
                }
                self.dateListText.text = dateStr
            }
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if let viewModel = viewModel, selected {
            self.delegate?.clickListEvent(self, listViewModel: viewModel)
        }
    }

    @IBAction func clickDeleteButton(_ sender: Any) {
        if let viewModel = viewModel {
            self.delegate?.clickDeleteEvent(self, listViewModel: viewModel)
        }
    }
    
    @objc func deleteConfirmEvent(){
        if let viewModel = viewModel {
            self.delegate?.clickDeleteEvent(self, listViewModel: viewModel)
        }
    }
    
    
    
}

protocol ListMainTableViewCellDelegate: class {
    func clickListEvent(_: ListMainTableViewCell, listViewModel: ListViewModel)
    func clickDeleteEvent(_:ListMainTableViewCell, listViewModel: ListViewModel)
}


