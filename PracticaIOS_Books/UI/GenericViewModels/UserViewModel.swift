//
//  UserViewModel.swift
//  PracticaIOS_Books
//
//  Created by Javier Martinez on 27/03/2021.
//

import Foundation

class UserViewModel {
    
    private let USERNAME_PATTERN = "^[a-zA-Z0-9_]{2,20}$"
    private let PASSWORD_PATTERN = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)[a-zA-Z\\d]{3,30}$"
    private let EMAIL_PATTERN = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,30}"
    private let COUNTRY_PATTERN = "^[ñA-Za-z _]{2,50}"
    private let GENDER_PATTERN = "[0-9]{1,1}"
    private let USERNAME_ERROR = "Error, el formato del username es incorrecto. Debe contener solo caracteres alfanuméricos entre 2 y 20."
    private let PASSWORD_ERROR = "Error, el formato de la password es incorrecto. Debe contener al menos una mayúscula, una minúscula y un número."
    private let EMAIL_ERROR = "Error, el formato del email es incorrecto."
    private let COUNTRY_ERROR = "Error, el formato del pais es incorrecto. Debe contener solo caracteres alfanuméricos entre 2 y 50."
    private let GENDER_ERROR = "Error, el formato del género es incorrecto. Elige una de las 3 opciones disponibles"
    private let DATE_ERROR = "Error, fecha de nacimiento no válida. Debe ser igual o superior a 18 años"
    var error: String?
    
    var user: UserResult
    
    init(email: String = "", username: String = "", birthdate: Date = Date(), gender: Int16 = 2, country: String = "", password: String = "") {
        user = UserResult(email: email, username: username, password: password, birthdate: birthdate, gender: gender, country: country)
    }
    
    
    func validateUsername() -> Bool{
        error = USERNAME_ERROR
        if let username = self.user.username {
            return StringUtils.validateStringFormat(regex: USERNAME_PATTERN, value: username )
        }
        
        return false
    }
    
    func validatePassword() -> Bool{
        error = PASSWORD_ERROR
        if let validatePass = self.user.password {
            return StringUtils.validateStringFormat(regex: PASSWORD_PATTERN, value: validatePass )
        }
        
        return false
    }
    
    func validateLogin() -> Bool {
        let res = validateUsername() && validatePassword()
        
        error = "Login error. Credentials don't match."
        return res
    }
    
    func validateRegister() -> Bool {
        if !self.validateEmail() {
            return false
        }
        if !self.validateUsername() {
            return false
        }
        if !self.validatePassword(){
            return false
        }
        if !self.validateDate(){
            return false
        }
        if !self.validateGender(){
            return false
        }
        if !self.validateCountry(){
            return false
        }
        
        return true
    }
    
    func validateUpdate() -> Bool {
        if !self.validateEmail() {
            return false
        }
        if !self.validateUsername() {
            return false
        }
        if !self.validateDate(){
            return false
        }
        if !self.validateGender(){
            return false
        }
        if !self.validateCountry(){
            return false
        }
        
        return true
    }
    
    func validateEmail() -> Bool{
        error = EMAIL_ERROR
        if let email = self.user.email {
            return StringUtils.validateStringFormat(regex: EMAIL_PATTERN, value: email )
        }
        
        return false
    }
    
    func validateGender() -> Bool{
        error = GENDER_ERROR
        if let gender = self.user.gender {
            if gender >= 0 && gender <= 2 {
                return true
            }
        }
        
        return false
    }
    
    func validateCountry() -> Bool{
        error = COUNTRY_ERROR
        if let country = self.user.country {
            return StringUtils.validateStringFormat(regex: COUNTRY_PATTERN, value: country )
        }
        
        return false
    }
    
    func validateDate() -> Bool{
        error = DATE_ERROR
        /*let minimumDate = Calendar.current.date(byAdding: .year, value: 18, to: Date())
        
        if minimumDate! <= date {
            return true
        }
            
        return false*/
        return true
    }
    
    func validatePasswords(newPass: String, oldPass: String) -> Bool {
        if newPass == oldPass {
            error = "New password must be diferent than the old one."
            return false
        }
        if validatePassword() {
            return true
        }
        return false
    }
    
    
    func getError() -> String {
        return error ?? "Error, formato incorrecto"
    }
}
