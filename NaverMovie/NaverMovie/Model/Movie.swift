//
//  Movie.swift
//  NaverMovie
//
//  Created by Bran on 2022/06/07.
//

import Foundation

// MARK: - Movie
struct Movie: Codable {
  let lastBuildDate: String
  let total, start, display: Int
  var items: [Item]
}

// MARK: - Item
struct Item: Codable {
  var title: String
  let link: String
  let image: String
  var subtitle, pubDate, director, actor: String
  let userRating: String
}

extension Item: Equatable {
  static func ==(lhs: Self, rhs: Self) -> Bool {
    return
    lhs.title == rhs.title &&
    lhs.subtitle == rhs.subtitle &&
    lhs.director == rhs.director
  }
}
