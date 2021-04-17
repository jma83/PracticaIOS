//
//  APIManager.swift
//  PracticaIOS_Books
//
//  Created by Javier Martinez on 03/04/2021.
//

import Foundation
class APIManager{
    func URLSessionQuery(query: String, type: String, completition: @escaping (Int?, String?)->()){
        var status = 500
        var result = "Bad Request"
        if let url = URL(string:query){
            var request = URLRequest(url:url);
            request.httpMethod = type
            
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                if data == nil || error != nil {
                    status = 400
                    result = "\(error!)"
                    completition(status,result)
                    return

                }
                if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {
                    status = httpStatus.statusCode
                    result = "\(response!)"
                    completition(status,result)
                    return

                }
                if let body_response = String(data: data!, encoding: String.Encoding.utf8) {
                    status = 200
                    result = body_response
                    completition(status,result)
                    return

                }
            }
            task.resume()
        }
    }
    
    func setNextParam(check:Bool, value:String) -> String{
        if !check {
            return value + "?"
        }else{
            return value + "&"
        }
    }
    
    func concatKey(url: String) -> String {
        let check = StringUtils.validateStringFormat(regex: ".*[?].*", value: url )
        return self.setNextParam(check: check, value: url)
    }
    
    
}
