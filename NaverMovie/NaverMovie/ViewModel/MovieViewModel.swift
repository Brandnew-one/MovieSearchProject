//
//  MovieViewModel.swift
//  NaverMovie
//
//  Created by Bran on 2022/06/08.
//

import Foundation

class MovieViewModel {
  var model: Movie = Movie()

  func fetchMovieData(
    _ searchData: String,
    completion: @escaping () -> Void
  ) {
    APIService.shared.requestMovie(searchName: searchData) { result in
      if case let .success(val) = result {
        self.model = val
        completion()
      }
    }
  }
}
