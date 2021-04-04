//
//  StringUtils.swift
//  PracticaIOS_Books
//
//  Created by Javier Martinez on 03/04/2021.
//

import Foundation


class StringUtils {
    static func validateStringFormat(regex: String, value: String) -> Bool {
        let predicate = NSPredicate(format:"SELF MATCHES %@", regex)
        let check = predicate.evaluate(with: value)
        
        return check
    }
}
