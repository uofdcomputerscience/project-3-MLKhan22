//
//  BookListViewController.swift
//  Project3Sample
//
//  Created by Russell Mirabelli on 11/16/19.
//  Copyright © 2019 Russell Mirabelli. All rights reserved.
//

import UIKit

class BookListViewController: UIViewController, UICollectionViewDelegate {
    
    let bookService = BookService.shared
    @IBOutlet weak var collectionViewer: UICollectionView!
    @IBOutlet weak var refreshBooks: UIButton!
    
    var selectedTitle: String = "Title: "
    var selectedAuthor: String = "Author: "
    var selectedPublishYear: String = "Published: "
    var selectedImage = UIImage(named: "noImg.jpg")
    var selectedID = -1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionViewer.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "UICollectionViewCell")
        self.collectionViewer.dataSource = self
        fetchBooks()
        collectionViewer.delegate = self
        //print(bookService.books.count)
    }
    
    @IBAction func refreshBooksTapped(_ sender: UIButton) {
        fetchBooks()
    }
    
    func fetchBooks() {
        bookService.fetchBooks { [weak self] in
            self?.setImage()
        }
    }
    
    func setImage() {
        let book = bookService.books.first!
        bookService.image(for: book) { [weak self] (retrievedBook, image) in
            if book.id == retrievedBook.id {
                DispatchQueue.main.async {
                    self?.collectionViewer.reloadData()
                }
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let book = bookService.books[indexPath.item]
        let cell = collectionView.cellForItem(at: indexPath)
        selectedTitle = "Title: " + book.title
        selectedAuthor = "Author: " + book.author
        selectedPublishYear = "Published: " + book.published
        if book.id != nil {
            selectedID = book.id!
        }
        if let view = cell as? CollectionViewCell{
            selectedImage = view.imageViewer.image
        }

        performSegue(withIdentifier: "presentModal", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "presentModal" {
            if let book = segue.destination as? BookDetailViewController {
                book.selectedTitle = selectedTitle
                book.selectedAuthor = selectedAuthor
                book.selectedPublishYear = selectedPublishYear
                book.selectedImage = selectedImage
                book.selectedID = selectedID
            }
        }
    }
}

extension BookListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return bookService.books.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath)
        //var uniqueBooks = Set([""])
        if let view = cell as? CollectionViewCell{
            bookService.image(for: bookService.books[indexPath.item]) { (retrievedBook, image) in
                if self.bookService.books[indexPath.item].id == retrievedBook.id{
                    DispatchQueue.main.async {
                        //uniqueBooks.insert(retrievedBook.title)
                        //view.bookTitle.text = self.bookService.books[indexPath.item].title
                        view.imageViewer.image = image
                        if(view.imageViewer.image == nil){
                            view.imageViewer.image = UIImage(named: "noImg.jpg")
                        }
                    }
                }
            }
        }
        //print(uniqueBooks)
        return cell
    }
    
}
