//
//  FavoritesView.swift
//  BookBuddy
//
//  Created by Meet Patel on 18/04/25.
//

import SwiftUI
import CoreData


struct FavoritesView: View {
    @Environment(\.managedObjectContext) private var viewContext

       @FetchRequest(
           entity: FavoriteBook.entity(),
           sortDescriptors: []
       ) var favorites: FetchedResults<FavoriteBook>

       var body: some View {
           NavigationView {
               List {
                   ForEach(favorites) { book in
                       NavigationLink(destination: BookDetailView(book: Book(
                           id: book.id ?? "",
                           volumeInfo: VolumeInfo(
                               title: book.title ?? "Unknown",
                               authors: [book.author ?? "Unknown"],
                               description: "",
                               imageLinks: ImageLinks(thumbnail: book.thumbnail ?? "")
                           )
                       ))) {
                           HStack {
                               if let urlString = book.thumbnail?.replacingOccurrences(of: "http://", with: "https://"),
                                  let url = URL(string: urlString) {
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
                               } else {
                                   Image(systemName: "book.closed")
                                       .resizable()
                                       .scaledToFit()
                                       .frame(width: 50, height: 75)
                                       .foregroundColor(.gray)
                               }

                               VStack(alignment: .leading) {
                                   Text(book.title ?? "")
                                       .font(.headline)
                                   Text(book.author ?? "")
                                       .font(.subheadline)
                                       .foregroundColor(.gray)
                               }
                           }
                       }
                   }
                   .onDelete(perform: deleteBooks)
               }

               .navigationTitle("Favorites")
               .toolbar {
                   EditButton()
               }
           }
       }

       private func deleteBooks(offsets: IndexSet) {
           withAnimation {
               offsets.map { favorites[$0] }.forEach(viewContext.delete)
               do {
                   try viewContext.save()
               } catch {
                   print("Error deleting favorite: \(error.localizedDescription)")
               }
           }
       }
   }
