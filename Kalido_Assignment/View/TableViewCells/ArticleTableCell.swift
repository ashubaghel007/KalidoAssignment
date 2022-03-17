//
//  ArticleTableCell.swift
//  Kalido_Assignment
//
//  Created by Ashish Baghel on 15/03/22.
//  Copyright © 2022 AshishBaghel. All rights reserved.
//

import UIKit

class ArticleTableCell: UITableViewCell {
    
    @IBOutlet private (set) weak var titleLabel: UILabel!
    @IBOutlet private (set) weak var detailLabel: UILabel!
    
    func updateUI(with item: ListItemDisplayable?) {
        guard let item = item else { return }
        titleLabel.text = item.title
        detailLabel.text = item.detail
    }
}

