//
//  BookInputViewController.swift
//  Project3Sample
//
//  Created by Russell Mirabelli on 11/16/19.
//  Copyright © 2019 Russell Mirabelli. All rights reserved.
//

import UIKit

class BookInputViewController: UIViewController, UITextFieldDelegate {
    let bookService = BookService.shared
    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var authorField: UITextField!
    @IBOutlet weak var publishedField: UITextField!
    @IBOutlet weak var imageURLField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleField.text = ""
        authorField.text = ""
        publishedField.text = ""
        imageURLField.text = ""
        imageURLField.placeholder = "(Optional)"
        self.titleField.delegate = self
        self.authorField.delegate = self
        self.publishedField.delegate = self
        self.imageURLField.delegate = self
    }
    
    @IBAction func submitTapped(_ sender: UIButton) {
        submitBook()
        _ = navigationController?.popViewController(animated: true)
    }
    
    func submitBook() {
        let book = Book(id: nil, title: titleField.text!, author: authorField.text!, published: publishedField.text!, imageURLString: imageURLField.text!)
        bookService.createBook(book: book) {
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}
