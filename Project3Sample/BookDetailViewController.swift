//
//  BookDetailViewController.swift
//  Project3Sample
//
//  Created by Russell Mirabelli on 11/16/19.
//  Copyright © 2019 Russell Mirabelli. All rights reserved.
//

import UIKit

class BookDetailViewController: UIViewController, UITableViewDelegate {
    
    var selectedTitle: String = "Title: "
    var selectedAuthor: String = "Author: "
    var selectedPublishYear: String = "Published: "
    var selectedImage = UIImage(named: "noImg.jpg")
    var selectedID = -1
    
    var selectedReviewer = "Reviewer: "
    var selectedDate = "On: "
    
    var indReviews: [Review] = []
    
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var bookTitle: UILabel!
    @IBOutlet weak var bookAuthor: UILabel!
    @IBOutlet weak var bookPublished: UILabel!
    @IBOutlet weak var bookReviews: UITableView!
    @IBOutlet weak var createReview: UIButton!
    
    let reviewService = ReviewService.shared
    @IBOutlet weak var tableViewer: UITableView!
    @IBOutlet weak var refreshReviews: UIButton!
    @IBOutlet weak var reviewBody: UITextView!
    
    let formatter = DateFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bookTitle.text = selectedTitle
        bookAuthor.text = selectedAuthor
        bookPublished.text = selectedPublishYear
        img.image = selectedImage
        reviewBody.text = ""
        self.tableViewer.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
        self.tableViewer.dataSource = self
        self.tableViewer.delegate = self
        fetchReviews()
        formatter.dateFormat = "MMM d, yyyy"
    }
    
    func fetchReviews() {
        reviewService.fetchReviews { [weak self] in
            DispatchQueue.main.async {
                self?.tableViewer.reloadData()
            }
        }
    }
    
    @IBAction func refreshReviewsTapped(_ sender: UIButton) {
        fetchReviews()
        indReviews = []
        reviewService.reviews.forEach { review in
            if(review.bookId == selectedID) {
                indReviews.append(review)
            }
        }
    }
    
    @IBAction func createReviewsTapped(_ sender: Any) {
        performSegue(withIdentifier: "createReview", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "createReview" {
            if let review = segue.destination as? ReviewInputViewController {
                review.book = selectedID
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let review = indReviews[indexPath.item]
        selectedReviewer = "Reviewer: " + review.reviewer
        reviewBody.text = ""+review.body
        if(review.date != nil) {
            selectedDate = "On: "+formatter.string(from: review.date!)
        }
        else {
            selectedDate = "On: Unknown Date"
        }
    }
}

extension BookDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return indReviews.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d, yyyy"
        let cell = tableView.dequeueReusableCell(withIdentifier: "BookRevCell", for: indexPath)
        if let rCell = cell as? BookRevCell{
            let review = indReviews[indexPath.item]
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
