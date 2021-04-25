//
//  CommentViewModel.swift
//  PracticaIOS_Books
//
//  Created by Javier Martinez on 25/04/2021.
//

import Foundation

class CommentViewModel {
    
    
    let commentResult: CommentResult
    
    init(comment: CommentResult) {
        self.commentResult = comment
    }

        
    var summary: String {
        return commentResult.summary ?? ""
    }
    
    var comment: String {
        return commentResult.comment ?? ""
    }
    
    var like: Bool {
        return commentResult.like ?? true
    }
    
    var date: Date {
        return commentResult.date ?? Date()
    }

    
}
