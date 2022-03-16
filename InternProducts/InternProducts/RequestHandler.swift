//
//  RequestHandler.swift
//  InternProducts
//
//  Created by Cristina Mihaela on 14.03.2022.
//

import Foundation

class RequestHandler {

    var dictionary = [String:Any]()

    

    func handler(url: URL, completionHandler: @escaping ([String:Any]) -> Void) {
       
       let session = URLSession(configuration: .default)

       let dataTask = session.dataTask(with: url) { [weak self] data, response, error in
           guard let self = self else { return }
           if let error = error {
               print("Request error. Received: \(error)")
           } else if let response = response as? HTTPURLResponse, response.statusCode != 200 {
               print("Request error, no 200 status. Received: \(response.statusCode)")
           } else if let data = data {
               // MARK: - process data
               do {
                   guard let jsonObject = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else {
                       print("Data serialization error: Unexpected data format")
                       return
                   }


                   self.dictionary = jsonObject
                   print(self.dictionary)
               } catch {
                   print("Data serialization error: \(error)")
               }

           } else {
               print("Request error, unexpected condition")
           }
       }
        dataTask.resume()
    }

    
}
