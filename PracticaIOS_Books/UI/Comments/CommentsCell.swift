//
//  CommentsCell.swift
//  PracticaIOS_Books
//
//  Created by Javier Martinez on 16/04/2021.
//

import UIKit

class CommentsCell: UITableViewCell {

    weak var delegate: CommentsCellDelegate?
    @IBOutlet weak var authorText: UILabel!
    
    @IBOutlet weak var summaryText: UILabel!
    @IBOutlet weak var commentText: UILabel!
    @IBOutlet weak var dateText: UILabel!
    @IBOutlet weak var rateImage: UIImageView!
    var viewModel: CommentViewModel? {
        didSet {
            if viewModel != nil {
                self.summaryText.text = viewModel?.summary
                self.commentText.text = viewModel?.comment
                self.authorText.text = "Pepe"
                self.rateImage.image = UIImage(systemName: "hand.thumbsup")
                
                let formatter1 = DateFormatter()
                formatter1.dateStyle = .long
                let dateStr = formatter1.string(from: viewModel!.date)
                self.dateText.text = dateStr
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
    
}

protocol CommentsCellDelegate: class {
    func clickCommentEvent(_: CommentsCell, commentViewModel: CommentViewModel)
}
