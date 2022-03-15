//
//  RequestHandler.swift
//  InternProducts
//
//  Created by Cristina Mihaela on 14.03.2022.
//

import Foundation

class RequestHandler {

    func handler() {
       let url = URL(string: "http://localhost:8080/login?username=admin&password=1234")!
       let session = URLSession(configuration: .default)

       let dataTask = session.dataTask(with: url) { data, response, error in
           if let error = error {
               print("Request error. Received: \(error)")
           } else if let response = response as? HTTPURLResponse, response.statusCode != 200 {
               print("Request error, no 200 status. Received: \(response.statusCode)")
           } else if let data = data {
               // MARK: - process data
               print(data)
           } else {
               print("Request error, unexpected condition")
           }
       }
        dataTask.resume()
    }

    
}
