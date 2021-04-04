//
//  BookGoogle.swift
//  PracticaIOS_Books
//
//  Created by Javier Martinez on 03/04/2021.
//

import Foundation

class BookGoogle: APIManager {
    let keyGoogle = "AIzaSyDYRLAp_eCC9aeyg4LysJXtNSqBDvPhZHg"

    
    struct FINAL_RESPONSE2: Decodable {
        var status: Int
        var response: Response_Google?
        var error: String?
    }
    
    struct Response_Google: Decodable {
        var kind: String
        var totalItems: Int
        var items: [BookGoogle]
    }

    struct BookGoogle: Decodable {
        var id: String
        var etag: String
        var selfLink: String
        var volumeInfo: BookGoogleInfo
    }

    struct BookGoogleInfo: Decodable {
        var title: String
        /*var authors: [String]
        var publisher: String
        var publishedDate: String
        var description: String
        var industryIdentifiers: [ISBN_ID]
        var language: String
        var categories: [String]*/
    }
    struct ISBN_ID: Decodable {
        var type: String
        var identifier: String
    }
        
    /*struct Image: Decodable {
        var thumbnail: String
        var smallThumbnail: String
    }*/
    
    
    func getGoogleAPIKey() -> String {
        return "key=\(self.keyGoogle)"
    }
    
    
    func getResponse(str: String, completition2: @escaping (FINAL_RESPONSE2?) -> ()) {
        var resultados: Response_Google?
        let url = concatKey(url: str) + getGoogleAPIKey()
        URLSessionQuery(query: url, type: "GET", completition: { (status,result) -> () in
            var error2: String?
            if let status = status, status == 200 {
                if let data = result?.data(using: .utf8){
                    do {
                        resultados = try JSONDecoder().decode(Response_Google.self, from: data)

                    }catch {

                        error2 = "Error: \(error)"

                    }
                }
            }else{
                error2 = "Error: \(result!)"
            }
            completition2(FINAL_RESPONSE2(status: status!, response: resultados, error: error2))
        })
    }

}
