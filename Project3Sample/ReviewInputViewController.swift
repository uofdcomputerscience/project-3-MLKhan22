//
//  ReviewInputViewController.swift
//  Project3Sample
//
//  Created by Russell Mirabelli on 11/16/19.
//  Copyright © 2019 Russell Mirabelli. All rights reserved.
//

import UIKit

class ReviewInputViewController: UIViewController, UITextFieldDelegate {
    let reviewService = ReviewService.shared
    var book = -1
    @IBOutlet weak var reviewTitle: UITextField!
    @IBOutlet weak var reviewer: UITextField!
    @IBOutlet weak var reviewText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        reviewTitle.text = ""
        reviewer.text = ""
        reviewText.text = ""
        reviewText.placeholder = "Your review here"
        self.reviewTitle.delegate = self
        self.reviewer.delegate = self
        self.reviewText.delegate = self
    }
    
    @IBAction func submitTapped(_ sender: UIButton) {
        submitReview()
        print("create review")
        _ = navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
    }
    
    func submitReview() {
        let review = Review(id: nil, bookId: book, date: Date(), reviewer: reviewer.text!, title: reviewTitle.text!, body: reviewText.text!)
        reviewService.createReview(review: review) {
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
}
