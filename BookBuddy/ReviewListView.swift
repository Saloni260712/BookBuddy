//
//  ReviewListView.swift
//  BookBuddy
//
//  Created by Meet Patel on 18/04/25.
//
import SwiftUI
import Firebase

struct Review: Identifiable {
    var id: String
    var bookID: String
    var userEmail: String
    var content: String
    var timestamp: Date
}

struct ReviewListView: View {
    var bookID: String
    @AppStorage("userEmail") var userEmail = ""

    @State private var newReview = ""
    @State private var reviews: [Review] = []
    
    

    var body: some View {
        VStack {
            Text("Reviews")
                .font(.title)
                .bold()

            List(reviews) { review in
                VStack(alignment: .leading) {
                    Text(review.userEmail)
                        .font(.caption)
                        .foregroundColor(.gray)
                    Text(review.content)
                }
            }

            HStack {
                TextField("Write a review...", text: $newReview)
                    .textFieldStyle(RoundedBorderTextFieldStyle())

                Button("Post") {
                    postReview()
                }
                .disabled(newReview.isEmpty)
            }
            .padding()
        }
        .onAppear {
            loadReviews()
        }
    }

    func postReview() {
        let db = Firestore.firestore()
        let newData: [String: Any] = [
            "bookID": bookID,
            "userEmail": userEmail,
            "content": newReview,
            "timestamp": Timestamp(date: Date())
        ]

        db.collection("reviews").addDocument(data: newData) { error in
            if let error = error {
                print("❌ Error posting review: \(error.localizedDescription)")
            } else {
                print("✅ Review posted!")
                newReview = ""
                loadReviews()
            }
        }
    }

    private func loadReviews() {
        let db = Firestore.firestore()
        db.collection("reviews")
            .whereField("bookID", isEqualTo: bookID)
            .order(by: "timestamp", descending: true)
            .getDocuments { snapshot, error in
                if let error = error {
                    print("❌ Error loading reviews: \(error.localizedDescription)")
                    return
                }

                guard let docs = snapshot?.documents else {
                    print("No reviews found.")
                    return
                }

                self.reviews = docs.map { doc in
                    let data = doc.data()
                    return Review(
                        id: doc.documentID,
                        bookID: data["bookID"] as? String ?? "",
                        userEmail: data["userEmail"] as? String ?? "",
                        content: data["content"] as? String ?? "",
                        timestamp: (data["timestamp"] as? Timestamp)?.dateValue() ?? Date()
                    )
                }
            }
    }

}
