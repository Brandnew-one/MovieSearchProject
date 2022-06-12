//
//  StarViewModel.swift
//  NaverMovie
//
//  Created by Bran on 2022/06/10.
//

import Foundation

class StarViewModel {
  var itemsDic = UserDefaultsManager.shared.movieDictionary.sorted { $0.key < $1.key }
  var items: [Item]?

  public init() {
    items = itemsDic.map{ $0.value }
  }
  
  func reloadUserDefaults() {
    let sortedDic = UserDefaultsManager.shared.movieDictionary.sorted { $0.key < $1.key }
    items = sortedDic.map{ $0.value }
  }

  func chekcUserDefaults(_ item: Item) -> Bool {
    return UserDefaultsManager.shared.containMovieList(item)
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
