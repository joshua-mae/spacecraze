//
//  HistoricalViewModel.swift
//  spacecraze
//
//  Created by Joshua Mae on 7/26/23.
//

import Foundation

//https://api.nasa.gov/planetary/apod?api_key=SJMpssjqLzUKFoPwQ6b482bJ1mrxGjt3KqCgyHUx&date=1995-06-16

class HistoricalViewModel: ObservableObject {

    @Published var historical: APOD
    
    init() {
        self.historical = APOD(date: "", explanation: "", hdurl: "https://apod.nasa.gov", mediaType: "", serviceVersion: "", title: "", url: "https://apod.nasa.gov")
    }

    func fetchImageOfThatDay(certainDate: Date) {
        let calendar = Calendar.current
        let year = String(calendar.component(.year, from: certainDate))
        let month = calendar.component(.month, from: certainDate)
        let day = calendar.component(.day, from: certainDate)

            // Create URL
            guard let url = URL(string: "https://api.nasa.gov/planetary/apod?api_key=SJMpssjqLzUKFoPwQ6b482bJ1mrxGjt3KqCgyHUx&date=\(year)-\(month)-\(day)") else {return}

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
                        self.historical = apod
                    }
                } catch {
                    print("Error decoding: \(error)")
                }
            }

            // Start Request
            task.resume()
        }
}






