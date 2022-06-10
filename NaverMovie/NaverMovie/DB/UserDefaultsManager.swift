//
//  UserDefaultsManager.swift
//  NaverMovie
//
//  Created by Bran on 2022/06/10.
//

import Foundation

class UserDefaultsManager {
  static let shared = UserDefaultsManager()
  private let userDefaultsKey = "StarList"
  private let userDefaults = UserDefaults.standard

  var movieDictionary: [String: Item] = [:]

  private init() { loadMovieList() }

  // MARK: - init
  private func loadMovieList() {
    guard
      let dic = userDefaults.value(forKey: userDefaultsKey) as? Data,
      let decodeDic = try? PropertyListDecoder().decode(Dictionary<String, Item>.self, from: dic)
    else {
      print("Load UserDefaults Error")
      return
    }
    self.movieDictionary = decodeDic
  }

  func appendMovieListItem(_ item: Item) {
    let key = item.title + item.subtitle + item.director
    if movieDictionary[key] == nil {
      self.movieDictionary[key] = item
    }
    userDefaults.setValue(try? PropertyListEncoder().encode(movieDictionary), forKey: userDefaultsKey)
  }

  func removeMovieListItem(_ item: Item) {
    let key = item.title + item.subtitle + item.director
    if movieDictionary[key] == nil {
      print("Invalid KeyValue")
      return
    }
    self.movieDictionary.removeValue(forKey: key)
    userDefaults.setValue(try? PropertyListEncoder().encode(movieDictionary), forKey: userDefaultsKey)
  }

  func containMovieList(_ item: Item) -> Bool {
    let key = item.title + item.subtitle + item.director
    if movieDictionary[key] == nil {
      return false
    } else {
      return true
    }
  }
}
