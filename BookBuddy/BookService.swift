//
//  BookService.swift
//  BookBuddy
//
//  Created by Meet Patel on 18/04/25.
//

import Foundation


class BookService {
    func searchBooks(query: String, completion: @escaping ([Book]) -> Void) {
        let formattedQuery = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        let urlStr = "https://www.googleapis.com/books/v1/volumes?q=\(formattedQuery)"

        guard let url = URL(string: urlStr) else {
            completion([])
            return
        }

        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                completion([])
                return
            }

            do {
                let result = try JSONDecoder().decode(BookResponse.self, from: data)
                DispatchQueue.main.async {
                    completion(result.items)
                }
            } catch {
                print("Decoding error:", error)
                completion([])
            }
        }.resume()
    }
}
