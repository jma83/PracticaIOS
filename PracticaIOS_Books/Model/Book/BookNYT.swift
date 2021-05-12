//
//  BookNYT.swift
//  PracticaIOS_Books
//
//  Created by Javier Martinez on 03/04/2021.
//

import Foundation


class BookNYT : APIManager {
    let keyNYT = "KrbdWbv8M6rKvLfZSBRCtcwQMDyNEu3M"
    
    struct Book : Decodable{
        var title: String
        var author: String
        var description: String
        var book_image: String
        var created_date: String
        var primary_isbn10: String
    }


    struct Category : Decodable {
        var list_id: Int
        var list_name: String
        var list_name_encoded: String
        var books: [Book]
        
    }

    struct Result_NYT: Decodable {
        var bestsellers_date: String
        var published_date: String
        var published_date_description: String
        var lists: [Category]
        
    }

    struct Response_NYT: Decodable {
        var status: String
        var copyright: String
        var num_results: Int
        var results: Result_NYT
    }
    
    struct FINAL_RESPONSE: Decodable {
        var status: Int
        var response: Response_NYT?
        var error: String?
    }
    
    func getNYTAPIKey() -> String {
        return "api-key=\(self.keyNYT)"
    }
    
    func getResponse(str: String, completition2: @escaping (FINAL_RESPONSE?) -> ()) {
        var resultados: Response_NYT?

        let url = concatKey(url: str) + getNYTAPIKey()
        print("URL!  \(url)")
        URLSessionQuery(query: url, type: "GET", completition: { (status,result) -> () in
            var error2: String?
            if let status = status, status == 200 {
                if let data = result?.data(using: .utf8){
                    do {
                        resultados = try JSONDecoder().decode(Response_NYT.self, from: data)
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
    
    func convertResponse(result: Result_NYT, maxSize: Int, completion: @escaping ([[BookResult]], [String]) -> ()){
        var count = 0
        var internalCount = 0
        var sectionArr: [String] = []
        var bookResultArr = [[BookResult]](repeating: [], count: maxSize)
        let arrItems = self.calcRandom(maxSize: maxSize, listSize: result.lists.count)

        for itemList in result.lists {
            if arrItems.contains(count){
                for book in itemList.books {
                    let bookresult = BookResult(id: book.primary_isbn10 ,title: book.title, author: book.author, description: book.description, book_image: book.book_image, created_date: book.created_date, primary_isbn10: book.primary_isbn10)
                    bookResultArr[internalCount].append(bookresult)
                }
                internalCount+=1
                sectionArr.append(itemList.list_name)
            }
            count+=1
        }
        completion(bookResultArr, sectionArr)
    }
        
    private func calcRandom(maxSize: Int, listSize: Int) -> [Int]{
        var arr:[Int] = []
        while maxSize > arr.count  {
            let result = Int.random(in: 0..<listSize)
            if !arr.contains(result){
                arr.append(result)
            }
        }
        return arr
    }
}
