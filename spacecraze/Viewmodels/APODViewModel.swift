//
//  APODViewModel.swift
//  spacecraze
//
//  Created by Joshua Mae on 7/25/23.
//

import Foundation
import UIKit


class APODViewModel: ObservableObject {
    
    @Published private(set) var apod: APOD
    
    init() {
        self.apod = APOD(date: "", explanation: "", hdurl: "https://apod.nasa.gov", mediaType: "", serviceVersion: "", title: "", url: "https://apod.nasa.gov")
    }
    
    func fetchImageOfTheDay() {

        // Create URL
        guard let url = URL(string: "https://api.nasa.gov/planetary/apod?api_key=SJMpssjqLzUKFoPwQ6b482bJ1mrxGjt3KqCgyHUx") else {
            print("Invalid URL")
            return
        }

        // Create Request
        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        // Fetch Request
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard error == nil else {
                print("Error: \(error!)")
                return
            }

            guard let data = data else {
                print("No data")
                return
            }

            // Decode Response
            do {
                let apod = try JSONDecoder().decode(APOD.self, from: data)
                DispatchQueue.main.async {
                    self.apod = apod
                }
            } catch {
                print("Error decoding: \(error)")
            }
        }

        // Start Request
        task.resume()
    }
    func downloadAndSaveImage(url: URL) {

      let task = URLSession.shared.dataTask(with: url) { data, _, error in
        guard let data = data, error == nil else {
          print(error?.localizedDescription ?? "No data")
          return
        }

        guard let image = UIImage(data: data) else {
          print("Could not create image")
          return
        }

          UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
      }

      task.resume()

    }
    

}
