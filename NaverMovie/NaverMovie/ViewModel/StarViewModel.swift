//
//  StarViewModel.swift
//  NaverMovie
//
//  Created by Bran on 2022/06/10.
//

import Foundation

class StarViewModel {
  var itemsDic = UserDefaultsManager.shared.movieDictionary
  var items: [Item]?

  public init() {
    items = itemsDic.values.map{ $0 }
  }

  func addUserDefaults(_ item: Item) {
    UserDefaultsManager.shared.appendMovieListItem(item)
    items?.append(item)
  }

  func removeUserDefaults(_ item: Item) {
    UserDefaultsManager.shared.removeMovieListItem(item)
    guard let index = items?.firstIndex(of: item) else { return }
    items?.remove(at: index)
  }

  func changeUserDefaults(_ item: Item) {
    if UserDefaultsManager.shared.containMovieList(item) {
      removeUserDefaults(item)
    } else {
      addUserDefaults(item)
    }
  }
  
}
