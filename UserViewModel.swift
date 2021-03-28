//
//  UserViewModel.swift
//  PracticaIOS_Books
//
//  Created by Javier Martinez on 27/03/2021.
//

import Foundation

class UserViewModel {
    
    let USERNAME_PATTERN = "[A-Z0-9a-z._]{2,20}"
    let PASSWORD_PATTERN = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)[a-zA-Z\\d]{5,30}$"
    let EMAIL_PATTERN = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,30}"
    let COUNTRY_PATTERN = "/^[ñA-Za-z _]*[ñA-Za-z][ñA-Za-z _]{2,50}*$/"
    
    
    
    func validateUsername(username: String?) -> Bool{
        if let username = username {
            return validateStringFormat(regex: USERNAME_PATTERN, value: username )
        }
        
        return false
    }
    
    func validatePassword(password: String?) -> Bool{
        if let password = password {
            return validateStringFormat(regex: PASSWORD_PATTERN, value: password )
        }
        
        return false
    }
    
    func validateEmail(email: String?) -> Bool{
        if let email = email {
            return validateStringFormat(regex: EMAIL_PATTERN, value: email )
        }
        
        return false
    }
    
    func validateCountry(country: String?) -> Bool{
        if let country = country {
            return validateStringFormat(regex: COUNTRY_PATTERN, value: country )
        }
        
        return false
    }
    
    func validateDate(date: Date) -> Bool{
        let yearComp = DateComponents(year: -18)
        let minimumDate = Calendar.current.date(byAdding: yearComp, to: Date())
        if minimumDate! <= date as Date{
            return true
        }
            
        return false
    }
    
    
    func validateStringFormat(regex: String, value: String) -> Bool {
        let predicate = NSPredicate(format:"SELF MATCHES %@", regex)
        let check = predicate.evaluate(with: value)
        
        return check
    }
}
