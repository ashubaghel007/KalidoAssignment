//
//  ArticleDetailViewController.swift
//  Kalido_Assignment
//
//  Created by Ashish Baghel on 18/03/22.
//  Copyright © 2022 AshishBaghel. All rights reserved.
//

import UIKit

class ArticleDetailViewController: UIViewController {
    
    @IBOutlet private (set) weak var authorName: UILabel!
    @IBOutlet private (set) weak var quote: UILabel!
    
    var article: Article?

    override func viewDidLoad() {
        super.viewDidLoad()
        title = article?.author
        authorName.text = article?.author
        quote.text = article?.quote
    }
}
