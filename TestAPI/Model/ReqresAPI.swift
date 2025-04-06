//
//  Model.swift
//  TestAPI
//
//  Created by Vasiliy on 06.04.2025.
//

import Foundation


struct MoviesResponse: Codable {
    let movies: [[Movie]]

    enum CodingKeys: String, CodingKey {
        case movies = "movies:"
    }
}

struct Movie: Codable {
    let title: String
    let genre: String
    let rating: String
    let country: String
    let duration: String
    let story: String
    let style: String
    let audience: String
    let plot: String
    let id: String
    let img: String
}
