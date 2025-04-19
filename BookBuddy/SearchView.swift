//
//  SearchView.swift
//  BookBuddy
//
//  Created by Meet Patel on 18/04/25.
//

import SwiftUI

struct SearchView: View {
    @State private var searchText = ""
    @State private var books: [Book] = []
    private let bookService = BookService()

    var body: some View {
        NavigationView {
            VStack {
                TextField("Search books...", text: $searchText, onCommit: fetchBooks)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()

                List(books) { book in
                    NavigationLink(destination: BookDetailView(book: book)) {
                        HStack {
                            if let urlString = book.volumeInfo.imageLinks?.thumbnail {
                                let secureURLString = urlString.replacingOccurrences(of: "http://", with: "https://")
                                if let url = URL(string: secureURLString) {
                                    AsyncImage(url: url) { image in
                                        image
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 50, height: 75)
                                            .cornerRadius(4)
                                    } placeholder: {
                                        ProgressView()
                                            .frame(width: 50, height: 75)
                                    }
                                }
                            } else {
                                Image(systemName: "book.closed")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 50, height: 75)
                                    .foregroundColor(.gray)
                            }


                            VStack(alignment: .leading) {
                                Text(book.volumeInfo.title ?? "No Title")
                                    .font(.headline)
                                Text(book.volumeInfo.authors?.joined(separator: ", ") ?? "")
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            }
                        }
                    }
                }

            }
            .navigationTitle("Search Books")
        }
    }

    private func fetchBooks() {
        bookService.searchBooks(query: searchText) { fetchedBooks in
            self.books = fetchedBooks
        }
    }
}
