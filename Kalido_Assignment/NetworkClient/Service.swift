//
//  Service.swift
//  Kalido_Assignment
//
//  Created by Ashish Baghel on 16/03/22.
//  Copyright © 2022 AshishBaghel. All rights reserved.
//

import Foundation

struct KalidoService {
    func getListItems(with file: String = "Article", completionHandler: @escaping ([Article]?, KalidoNetworkError?) -> Void) {
        KalidoNetworkClient.shared.getLocalJSON(with: file) { (data, error) in
            if let data = data {
                if let articles = try? JSONDecoder().decode([Article].self, from: data) {
                    completionHandler(articles, nil)
                } else {
                    completionHandler(nil, .invalidData)
                }
            } else if let error = error {
                completionHandler(nil, error)
            }
        }
    }
}
