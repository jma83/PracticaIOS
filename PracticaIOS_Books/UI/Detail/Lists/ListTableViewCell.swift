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
                self.nameListText.text = viewModel?.list!.name ?? ""
                let formatter1 = DateFormatter()
                formatter1.dateStyle = .long
                var dateStr = ""
                if let date = viewModel?.list!.updateDate {
                    dateStr = formatter1.string(from: date)
                }
                self.dateListText.text = dateStr

                if let active = viewModel?.active {
                    self.switchList.setOn(active, animated: true)
                }
            }
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    @IBAction func toggleSwitch(_ sender: Any) {
        if let vm = viewModel, let isOn = self.switchList?.isOn {
            self.delegate?.toggleListEvent(self, listViewModel: vm, isOn: isOn)
        }
    }
    
}

protocol ListTableViewCellDelegate: class {
    func toggleListEvent(_: ListTableViewCell, listViewModel: ListViewModel, isOn: Bool)
}

