//
//  CommentViewModel.swift
//  PracticaIOS_Books
//
//  Created by Javier Martinez on 25/04/2021.
//

import Foundation

class CommentViewModel {
    
    
    let comment: Comment
    var ownComment: Bool
    
    init(comment: Comment, ownComment: Bool = false) {
        self.comment = comment
        self.ownComment = ownComment
    }

        
    var summary: String {
        return comment.summary ?? ""
    }
    
    var descrip: String {
        return comment.comment ?? ""
    }
    
    var like: Bool {
        return comment.like
    }
    
    var date: Date {
        return comment.updateDate ?? Date()
    }
    
    var author: String {
        if let user = comment.user {
            return user.username!
        }
        return ""
    }

    
}
