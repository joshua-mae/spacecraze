//
//  HistoricalViewModel.swift
//  spacecraze
//
//  Created by Joshua Mae on 7/26/23.
//

import Foundation

//https://api.nasa.gov/planetary/apod?api_key=SJMpssjqLzUKFoPwQ6b482bJ1mrxGjt3KqCgyHUx&date=1995-06-16

class HistoricalViewModel: ObservableObject {
    
    @Published var historical: APOD?

    func fetchImageOfThatDay(certainDate: Date) {
        let calendar = Calendar.current
        let year = String(calendar.component(.year, from: certainDate))
        let month = calendar.component(.month, from: certainDate)
        let day = calendar.component(.day, from: certainDate)
        guard let url = URL(string: "https://api.nasa.gov/planetary/apod?api_key=SJMpssjqLzUKFoPwQ6b482bJ1mrxGjt3KqCgyHUx&date=\(year)-\(month)-\(day)") else {return}
        
        URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let data = data, error == nil else {return}
            
            do {
                let historical = try JSONDecoder().decode(APOD.self, from: data)
                DispatchQueue.main.async {
                    self?.historical = historical
                }
            } catch {
                print(error)
            }
        }.resume()
    }
}



