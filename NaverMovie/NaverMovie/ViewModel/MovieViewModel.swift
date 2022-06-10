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
            print(val.start)
            self.total = val.total
            self.start = val.start
            tempMovie.items.forEach { self.model?.items.append($0) }
            completion()
          }
        }
    }
  }

  // TODO: - 고차함수로 바꿔보기
  private func setMovieData(model: Movie) -> Movie {
    var result = model
    for i in 0..<result.items.count {
      result.items[i].title = result.items[i].title.replacingOccurrences(of: "<b>", with: "")
      result.items[i].title = result.items[i].title.replacingOccurrences(of: "</b>", with: "")
      // MARK: - 수정필요
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
