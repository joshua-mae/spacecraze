//
//  APODViewModel.swift
//  spacecraze
//
//  Created by Joshua Mae on 7/25/23.
//

import Foundation

class APODViewModel: ObservableObject {
    
    @Published var apod: APOD?
    
    func fetchImageOfTheDay() {
        guard let url = URL(string: "https://api.nasa.gov/planetary/apod?api_key=SJMpssjqLzUKFoPwQ6b482bJ1mrxGjt3KqCgyHUx") else {return}
        
        URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let data = data, error == nil else {return}
            
            do {
                let apod = try JSONDecoder().decode(APOD.self, from: data)
                DispatchQueue.main.async {
                    self?.apod = apod
                }
                
            } catch {
                print(error)
            }
        }.resume()
    }
}
