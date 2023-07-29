//
//  ApodModel.swift
//  spacecraze
//
//  Created by Joshua Mae on 7/25/23.
//

import Foundation

/*
 API GET: https://api.nasa.gov/planetary/apod?api_key=SJMpssjqLzUKFoPwQ6b482bJ1mrxGjt3KqCgyHUx
 */

// MARK: - APOD
struct APOD: Decodable {
    let date, explanation: String?
    let hdurl: URL?
    let mediaType, serviceVersion, title: String?
    let url: URL?

    enum CodingKeys: String, CodingKey {
        case date, explanation, hdurl
        case mediaType = "media_type"
        case serviceVersion = "service_version"
        case title, url
    }
}
