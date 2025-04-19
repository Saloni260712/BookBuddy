//
//  BookDetailView.swift
//  BookBuddy
//
//  Created by Meet Patel on 18/04/25.
//
import SwiftUI
import CoreData

struct BookDetailView: View {
    let book: Book
    @Environment(\.managedObjectContext) private var viewContext
    @State private var showToast = false

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                if let urlString = book.volumeInfo.imageLinks?.thumbnail,
                   let url = URL(string: urlString.replacingOccurrences(of: "http://", with: "https://")) {
                    AsyncImage(url: url) { phase in
                        switch phase {
                        case .empty:
                            ProgressView()
                        case .success(let image):
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(maxWidth: .infinity)
                        case .failure:
                            Image(systemName: "photo")
                                .resizable()
                                .scaledToFit()
                                .frame(height: 200)
                                .foregroundColor(.gray)
                        @unknown default:
                            EmptyView()
                        }
                    }
                } else {
                    Rectangle()
                        .fill(Color.gray.opacity(0.3))
                        .frame(height: 200)
                        .cornerRadius(12)
                }

                Text(book.volumeInfo.title)
                    .font(.title)
                    .bold()

                if let authors = book.volumeInfo.authors {
                    Text("By \(authors.joined(separator: ", "))")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }

                if let description = book.volumeInfo.description {
                    Text(description)
                        .font(.body)
                        .padding(.top, 4)
                }

                Button(action: {
                    saveToFavorites(book)
                }) {
                    Label("Save to Favorites", systemImage: "star.fill")
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(12)

                NavigationLink(destination: ReviewListView(bookID: book.id ?? "")) {
                    Label("Read Reviews", systemImage: "text.bubble")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                }
            }
            .padding()
        }
        .navigationTitle("Book Details")
        .overlay(
            VStack {
                if showToast {
                    Text("Book added to Favorites")
                        .font(.subheadline)
                        .padding()
                        .background(Color.green.opacity(0.95))
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .transition(.move(edge: .top))
                        .onAppear {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                withAnimation {
                                    showToast = false
                                }
                            }
                        }
                }
                Spacer()
            }
            .padding()
        )
    }

    func saveToFavorites(_ book: Book) {
        let newFavorite = FavoriteBook(context: viewContext)
        newFavorite.id = book.id
        newFavorite.title = book.volumeInfo.title
        newFavorite.author = book.volumeInfo.authors?.joined(separator: ", ")
        newFavorite.thumbnail = book.volumeInfo.imageLinks?.thumbnail

        do {
            try viewContext.save()
            showToast = true
            print("Saved \(book.volumeInfo.title) to favorites.")
        } catch {
            print("Failed to save favorite: \(error.localizedDescription)")
        }
    }
}


#Preview {
    BookDetailView(book: Book(
        id: "sample",
        volumeInfo: VolumeInfo(
            title: "Sample Book",
            authors: ["Jane Doe"],
            description: "A test book with an image for preview purposes.",
            imageLinks: ImageLinks(thumbnail: "https://books.google.com/books/content?id=Zf5G9g&printsec=frontcover&img=1&zoom=1&source=gbs_api")
        )
    ))
    .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
