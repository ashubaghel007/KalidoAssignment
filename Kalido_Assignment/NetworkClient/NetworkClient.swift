//
//  NetworkClient.swift
//  Kalido_Assignment
//
//  Created by Ashish Baghel on 16/03/22.
//  Copyright © 2022 AshishBaghel. All rights reserved.
//

import Foundation

struct KalidoNetworkClient {
    static var shared = KalidoNetworkClient()
    var urlSession = URLSession.shared
    private init() { }
    
    func sendPostRequest(to url: URL, body: Data, completionHandler: @escaping (Data?, KalidoNetworkError?) -> Void) {
        var request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData)
        request.httpMethod = "POST"
        request.httpBody = body
        
        urlSession.dataTask( with: request, completionHandler: { data, response, error in
            completionHandler(data, error as? KalidoNetworkError)
        }).resume()
    }
    
    func getData(with url: URL?, completionHandler: @escaping (Data?, KalidoNetworkError?) -> Void) {
        guard let url = url else { return  completionHandler(nil ,.badException) }
        urlSession.dataTask(with: url) { data, response, error in
            completionHandler(data, error as? KalidoNetworkError)
            }.resume()
    }
    
    func getLocalJSON(with file: String?, completionHandler: @escaping (Data?, KalidoNetworkError?) -> Void) {
        guard let file = file else { return  completionHandler(nil ,.badException)}
        do {
            if let bundlePath = Bundle.main.path(forResource: file,
                                                 ofType: "json"),
                let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
                completionHandler(jsonData, nil)
            }
        } catch let error {
            completionHandler(nil, error as? KalidoNetworkError)
        }
    }
}


enum KalidoNetworkError: Error {
    case badException
    case invalidData
}
