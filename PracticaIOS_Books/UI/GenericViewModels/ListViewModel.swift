//
//  ListViewModel.swift
//  PracticaIOS_Books
//
//  Created by Javier Martinez on 25/04/2021.
//

import Foundation

class ListViewModel {
    
    
    var list: List?
    var listResult: ListResult?
    var active: Bool?
    var error: String?
    
    init(list: List, active: Bool = false) {
        self.list = list
        self.active = active
    }
    
    init(name: String = "", date: Date = Date()) {
        listResult = ListResult(name: name, date: date)
    }
    
    func validate() -> Bool {
        error = "Error, list name must have at least 3 characters."
        guard let name = self.listResult?.name else {
            return false
        }
        
        if name.count <= 2 {
            return false
        }
        
        return true
    }
    
    func getError() -> String {
        return error ?? ""
    }
    
}
