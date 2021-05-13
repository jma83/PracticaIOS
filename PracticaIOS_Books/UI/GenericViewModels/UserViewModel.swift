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
    
    private let USERNAME_ERROR = "Error, the username format is incorrect. Must contain between 2 and 20 alphanumeric characters."
    private let PASSWORD_ERROR = "Error, password format is incorrect. Must contain at least an uppercase, a lowercase and a number."
    private let EMAIL_ERROR = "Error, email format is incorrect."
    private let COUNTRY_ERROR = "Error, the country format is incorrect. Must contain between 2 and 50 alphanumeric characters."
    private let GENDER_ERROR = "Error, the gender format is incorrect. Choose within the available options."
    private let DATE_ERROR = "Error, birthdte is invalid. Must be greater or equals than 18 years old."
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
        let yearComp = DateComponents(year: -18)
        let date = Calendar.current.date(byAdding: yearComp, to: Date())
        let res = Calendar.current.component(.year, from: date!)
        let res2 = Calendar.current.component(.year, from: self.user.birthdate!)
        if res >= res2 {
            return true
        }
        return false
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
        return error ?? "Error, invalid format"
    }
}
