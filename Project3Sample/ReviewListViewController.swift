//
//  ReviewListViewController.swift
//  Project3Sample
//
//  Created by Russell Mirabelli on 11/16/19.
//  Copyright © 2019 Russell Mirabelli. All rights reserved.
//

import UIKit

class ReviewListViewController: UIViewController, UITableViewDelegate {
    
    var selectedBook = "Book: "
    var selectedTitle = "Title: "
    var selectedReviewer = "Reviewer: "
    var selectedDate = "On: "
    var selectedBody = ""
    
    let formatter = DateFormatter()
    
    let reviewService = ReviewService.shared
    let bookService = BookService.shared
    @IBOutlet weak var tableViewer: UITableView!
    @IBOutlet weak var refreshReviews: UIButton!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableViewer.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
        self.tableViewer.dataSource = self
        self.tableViewer.delegate = self
        fetchReviewsAndBooks()
        formatter.dateFormat = "MMM d, yyyy"
    }
    
    func fetchReviewsAndBooks() {
        reviewService.fetchReviews { [weak self] in
            DispatchQueue.main.async {
                self?.tableViewer.reloadData()
            }
        }
        bookService.fetchBooks { [weak self] in
            DispatchQueue.main.async {
                self?.tableViewer.reloadData()
            }
        }
    }
    
    @IBAction func refreshReviewsTapped(_ sender: UIButton) {
        fetchReviewsAndBooks()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let review = reviewService.reviews[indexPath.item]
        selectedBook = "Book: " + bookService.books[review.bookId].title
        selectedTitle = "Title: " + review.title
        selectedReviewer = "Reviewer: " + review.reviewer
        selectedBody = ""+review.body
        if(review.date != nil) {
            selectedDate = "On: "+formatter.string(from: review.date!)
        }
        else {
            selectedDate = "On: Unknown Date"
        }
        performSegue(withIdentifier: "reviewModal", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "reviewModal" {
            if let review = segue.destination as? ReviewDetailViewController {
                review.selectedBTitle = selectedBook
                review.selectedRTitle = selectedTitle
                review.selectedReviewer = selectedReviewer
                review.selectedDate = selectedDate
                review.selectedBody = selectedBody
            }
        }
    }
    
}

extension ReviewListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reviewService.reviews.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d, yyyy"
        let cell = tableView.dequeueReusableCell(withIdentifier: "RevCell", for: indexPath)
        if let rCell = cell as? RevCell{
            let review = reviewService.reviews[indexPath.item]
            rCell.bookTitle.text = "Book: "+bookService.books[review.bookId].title
            rCell.revTitle.text = "Title: "+review.title
            rCell.reviewer.text = "Reviewer: "+review.reviewer
            if(review.date != nil) {
                rCell.reviewDate.text = "On: "+formatter.string(from: review.date!)
            }
            else {
                rCell.reviewDate.text = "On: Unknown Date"
            }
        }
        
        return cell
    }
    
}

