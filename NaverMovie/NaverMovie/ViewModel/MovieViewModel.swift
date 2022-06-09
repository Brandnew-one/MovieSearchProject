//
//  MovieViewModel.swift
//  NaverMovie
//
//  Created by Bran on 2022/06/08.
//

import Foundation

class MovieViewModel {
  var model: Movie?

  func fetchMovieData(
    _ searchData: String,
    completion: @escaping () -> Void
  ) {
    APIService.shared.requestMovie(searchName: searchData) { result in
      if case let .success(val) = result {
        self.model = self.setMovieTitle(model: val)
        completion()
      }
    }
  }

  // TODO: - 고차함수로 바꿔보기
  func setMovieTitle(model: Movie) -> Movie {
    var result = model
    for i in 0..<result.items.count {
      result.items[i].title = result.items[i].title.replacingOccurrences(of: "<b>", with: "")
      result.items[i].title = result.items[i].title.replacingOccurrences(of: "</b>", with: "")
    }
    return result
  }
}
