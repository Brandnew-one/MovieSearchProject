//
//  MovieViewModel.swift
//  NaverMovie
//
//  Created by Bran on 2022/06/08.
//

import Foundation

class MovieViewModel {
  var model: Movie?
  private let display = 10
  private var start = 1
  private var total = 0

  func fetchMovieData(
    _ searchData: String,
    completion: @escaping () -> Void
  ) {
    APIService.shared.requestMovie(searchName: searchData) { result in
      if case let .success(val) = result {
        self.total = val.total
        self.start = val.start
        self.model = self.setMovieData(model: val)
        completion()
      }
    }
  }

  func paginationMovieData(
    _ searchData: String,
    completion: @escaping () -> Void
  ) {
    if start + display > total {
      return
    } else {
      APIService.shared.requestMovie(
        searchName: searchData,
        start: start + 10) { result in
          if case let .success(val) = result {
            var tempMovie: Movie = val
            tempMovie = self.setMovieData(model: tempMovie)
            self.total = val.total
            self.start = val.start
            // MARK: - 현재 중복되는 값이 계속해서 들어가는 문제가 있어 중복되지 않는 경우에만 넣어주도록 설정
            tempMovie.items.forEach {
              if !(self.model?.items.contains($0) ?? false) {
                self.model?.items.append($0)
              }
              completion()
            }
          }
      }
    }
  }

  func checkUserDefaults(_ item: Item) -> Bool {
    return UserDefaultsManager.shared.containMovieList(item)
  }

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

  private func setMovieData(model: Movie) -> Movie {
    var result = model
    for i in 0..<result.items.count {
      result.items[i].title = result.items[i].title
        .replacingOccurrences(of: "<b>", with: "")
        .replacingOccurrences(of: "</b>", with: "")
      result.items[i].actor = result.items[i].actor.replacingOccurrences(of: "|", with: ",")
      result.items[i].director = result.items[i].director.replacingOccurrences(of: "|", with: ",")
      result.items[i].actor = removeLastChar(result.items[i].actor)
      result.items[i].director = removeLastChar(result.items[i].director)
    }
    return result
  }

  private func removeLastChar(_ str: String) -> String {
    var removeStr = str
    if let lastIndex = removeStr.lastIndex(of: ",") {
      removeStr.remove(at: lastIndex)
    }
    return removeStr
  }
}
