//
//  BookGoogle.swift
//  PracticaIOS_Books
//
//  Created by Javier Martinez on 03/04/2021.
//

import Foundation

class BookGoogle: APIManager {
    let keyGoogle = "AIzaSyDYRLAp_eCC9aeyg4LysJXtNSqBDvPhZHg"

    
    struct FINAL_RESPONSE: Decodable {
        var status: Int
        var response: Response_Google?
        var error: String?
    }
    
    struct Response_Google: Decodable {
        var items: [BookGoogle]
    }
    
    struct BookGoogle: Decodable {
        var id: String
        var volumeInfo: BookGoogleInfo
    }
    
    struct BookGoogleInfo: Decodable {
        var title: String?
        var subtitle: String?
        var authors: [String]?
        var publishedDate: String?
        var description: String?
        var industryIdentifiers: [ISBN_ID?]?
        var imageLinks: ImageInfo?
        var categories: [String]?
    }
    struct ISBN_ID: Decodable {
        var identifier: String?
    }
        
    struct ImageInfo: Decodable {
        var thumbnail: String?
    }
    
    
    func getGoogleAPIKey() -> String {
        return "key=\(self.keyGoogle)"
    }
    
    
    func getResponse(str: String, completition2: @escaping (FINAL_RESPONSE?) -> ()) {
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
            completition2(FINAL_RESPONSE(status: status!, response: resultados, error: error2))
        })
    }
    
    func convertResponse(response: Response_Google, maxSize: Int, completion: @escaping ([BookResult]) -> ()) {
        var bookResultArr = [BookResult]()
        var internalCount = 0
        for item in response.items {
            if internalCount == maxSize {
                break
            }
            let book = item.volumeInfo
            let bookresult = BookResult(id: item.id, title: book.title, author: book.authors?[0] ?? "N/A", description: book.description, book_image: book.imageLinks?.thumbnail, created_date: book.publishedDate, primary_isbn10: book.industryIdentifiers?[0]?.identifier ?? "")
            bookResultArr.append(bookresult)
            internalCount+=1
        }
        completion(bookResultArr)
    }

}
