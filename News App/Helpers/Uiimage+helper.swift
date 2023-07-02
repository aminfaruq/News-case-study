//
//  Uiimage+helper.swift
//  News App
//
//  Created by Amin faruq on 18/06/23.
//

import UIKit

extension UIImageView {
    
    func setImage(from url: URL) {
        let task = URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            if let error = error {
                //Handle error
                print("Error: \(error)")
                return
            }
            
            if let response = response as? HTTPURLResponse, response.statusCode == 200 {
                if let data = data, let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                } else {
                    // Handle empty data or invalid image
                    print("empty data or invalid image")
                }
            } else {
                // handle invalid response or non - 200 status code
                print("Invalid response or non - 200 status code")
            }
        }
        
        task.resume()
    }
}

