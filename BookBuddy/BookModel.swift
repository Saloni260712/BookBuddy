//
//  BookModel.swift
//  BookBuddy
//
//  Created by Meet Patel on 18/04/25.
//

import Foundation

struct BookResponse: Decodable {
    let items: [Book]
}

struct Book: Decodable, Identifiable {
    let id: String
    let volumeInfo: VolumeInfo
}

struct VolumeInfo: Decodable {
    let title: String
    let authors: [String]?
    let description: String?
    let imageLinks: ImageLinks?
}

struct ImageLinks: Decodable {
    let thumbnail: String?
}

