//
//  ListViewModel.swift
//  PracticaIOS_Books
//
//  Created by Javier Martinez on 25/04/2021.
//

import Foundation

class ListViewModel {
    
    
    let list: ListResult
    
    init(list: ListResult) {
        self.list = list
    }

        
    var name: String {
        return list.name ?? ""
    }
    
    var date: Date {
        return list.date ?? Date()
    }

    
}
