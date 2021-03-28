//
//  UserViewModel.swift
//  PracticaIOS_Books
//
//  Created by Javier Martinez on 27/03/2021.
//

import Foundation

class UserViewModel {
    
    let USERNAME_PATTERN = "^[a-zA-Z0-9_]{2,20}$"
    let PASSWORD_PATTERN = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)[a-zA-Z\\d]{3,30}$"
    let EMAIL_PATTERN = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,30}"
    let COUNTRY_PATTERN = "/^[ñA-Za-z _]*[ñA-Za-z][ñA-Za-z _]${2,50}/"
    let GENDER_PATTERN = "[0-9]{1,1}"
    let USERNAME_ERROR = "Error, el formato del username es incorrecto. Debe contener solo caracteres alfanuméricos entre 2 y 20."
    let PASSWORD_ERROR = "Error, el formato de la password es incorrecto. Debe contener al menos una mayúscula, una minúscula y un número."
    let EMAIL_ERROR = "Error, el formato del email es incorrecto."
    let COUNTRY_ERROR = "Error, el formato del pais es incorrecto. Debe contener solo caracteres alfanuméricos entre 2 y 50."
    let GENDER_ERROR = "Error, el formato del género es incorrecto. Elige una de las 3 opciones disponibles"
    let DATE_ERROR = "Error, fecha de nacimiento no válida. Debe ser igual o superior a 18 años"
    var error: String?
    
    
    
    func validateUsername(username: String?) -> Bool{
        error = USERNAME_ERROR
        if let username = username {
            return validateStringFormat(regex: USERNAME_PATTERN, value: username )
        }
        
        return false
    }
    
    func validatePassword(password: String?) -> Bool{
        error = PASSWORD_ERROR
        if let password = password {
            return validateStringFormat(regex: PASSWORD_PATTERN, value: password )
        }
        
        return false
    }
    
    func validateLogin(username: String?, password: String?) -> Bool {
        let res = validateUsername(username: username) && validatePassword(password: password)
        
        error = "Error, login incorrecto. Revise los datos y vuelva a intentarlo"
        return res
    }
    
    func validateEmail(email: String?) -> Bool{
        error = EMAIL_ERROR
        if let email = email {
            return validateStringFormat(regex: EMAIL_PATTERN, value: email )
        }
        
        return false
    }
    
    func validateGender(gender: Int?) -> Bool{
        error = GENDER_ERROR
        if let gender = gender {
            return validateIntFormat(regex: GENDER_PATTERN, value: gender )
        }
        
        return false
    }
    
    func validateCountry(country: String?) -> Bool{
        error = COUNTRY_ERROR
        if let country = country {
            return validateStringFormat(regex: COUNTRY_PATTERN, value: country )
        }
        
        return false
    }
    
    func validateDate(date: Date) -> Bool{
        error = DATE_ERROR
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
    
    func validateIntFormat(regex: String, value: Int) -> Bool {
        let predicate = NSPredicate(format:"SELF MATCHES %@", regex)
        let check = predicate.evaluate(with: value)
        
        return check
    }
    
    func getError() -> String {
        return error ?? "Error, formato incorrecto"
    }
}
