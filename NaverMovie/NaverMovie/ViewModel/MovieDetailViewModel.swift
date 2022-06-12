//
//  MovieDetailViewModel.swift
//  NaverMovie
//
//  Created by Bran on 2022/06/12.
//

import Foundation

class MovieDetailViewModel {
  var item: Item?

  func checkUserDefaults() -> Bool {
    guard let item = item else { return false }
    return UserDefaultsManager.shared.containMovieList(item)
  }

  // TODO: - MovieViewModel이랑 중복되는데 줄일 수 있는 방법이 있을지 고민해보기

  func addUserDefaults(_ item: Item) {
    UserDefaultsManager.shared.appendMovieListItem(item)
  }

  func removeUserDefaults(_ item: Item) {
    UserDefaultsManager.shared.removeMovieListItem(item)
  }

  func changeUserDefaults(_ item: Item) {
    if UserDefaultsManager.shared.containMovieList(item) {
      removeUserDefaults(item)
    } else {
      addUserDefaults(item)
    }
  }
}
