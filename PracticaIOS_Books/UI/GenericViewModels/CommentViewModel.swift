//
//  CommentViewModel.swift
//  PracticaIOS_Books
//
//  Created by Javier Martinez on 25/04/2021.
//

import Foundation

class CommentViewModel {
    
    var commentResult: CommentResult?
    var comment: Comment?
    var ownComment: Bool?
    var error: String?
    
    init(comment: Comment, ownComment: Bool = false) {
        self.comment = comment
        self.ownComment = ownComment
    }
    
    init(summary: String = "", descrip: String = "", like: Bool = false, date: Date? = nil) {
        self.commentResult = CommentResult(summary: summary, comment: descrip, like: like, date: date)
    }


    func validate() -> Bool {
        if let summary = self.commentResult?.summary, summary.count <= 2 {
            self.error = "Error summary must be greater than 2 chars"
            return false
        }
        
        if let descrip = self.commentResult?.comment, descrip.count <= 6 {
            self.error = "Error description must be greater than 6 chars"
            return false
        }
        return true
    }
    
    func getError() -> String {
        return error ?? ""
    }
    
    

    
}
