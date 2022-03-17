//
//  Article.swift
//  Kalido_Assignment
//
//  Created by Ashish Baghel on 16/03/22.
//  Copyright © 2022 AshishBaghel. All rights reserved.
//

import Foundation
import UIKit

struct Article: Codable {
    var id: Int?
    var quote: String?
    var author: String?
}

extension Article: ListItemDisplayable {
    var title: String? {
        return author
    }
    
    var detail: String? {
        return quote
    }
}
