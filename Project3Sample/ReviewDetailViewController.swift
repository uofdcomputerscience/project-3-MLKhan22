//
//  ReviewDetailViewController.swift
//  Project3Sample
//
//  Created by Russell Mirabelli on 11/16/19.
//  Copyright © 2019 Russell Mirabelli. All rights reserved.
//

import UIKit

class ReviewDetailViewController: UIViewController {
    
    var selectedBTitle: String = "Book: "
    var selectedRTitle: String = "Title: "
    var selectedReviewer: String = "Reviewer: "
    var selectedDate: String = "On: "
    var selectedBody: String =  ""
    
    @IBOutlet weak var bookTitle: UILabel!
    @IBOutlet weak var revTitle: UILabel!
    @IBOutlet weak var bookReviewer: UILabel!
    @IBOutlet weak var dateReviewed: UILabel!
    @IBOutlet weak var reviewBody: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bookTitle.text = selectedBTitle
        revTitle.text = selectedRTitle
        bookReviewer.text = selectedReviewer
        dateReviewed.text = selectedDate
        reviewBody.text = selectedBody
    }
    
    
    
}
