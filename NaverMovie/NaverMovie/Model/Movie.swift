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
  let items: [Item]

  public init() {
    self.lastBuildDate = ""
    self.total = -1
    self.start = -1
    self.display = -1
    self.items = []
  }
}

// MARK: - Item
struct Item: Codable {
  let title: String
  let link: String
  let image: String
  let subtitle, pubDate, director, actor: String
  let userRating: String
}
