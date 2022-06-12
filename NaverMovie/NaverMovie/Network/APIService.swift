//
//  APIService.swift
//  NaverMovie
//
//  Created by Bran on 2022/06/08.
//

import UIKit

// TODO: - 추가하기!
enum NetworkError: Error {
  case basic
  case decodeError
}

class APIService {
  static let shared = APIService()
  private let baseURL = URL(string: "https://openapi.naver.com/v1/search/movie.json")!

  private init() { }

  // TODO: - 함수 분할 필요
  func requestMovie(
    searchName: String,
    display: Int = 10,
    start: Int = 1,
    completion: @escaping (Result<Movie, NetworkError>) -> Void
  ) {
    guard
      let plist = Bundle.main.url(forResource: "API", withExtension: "plist"),
      let dictionary = NSDictionary(contentsOf: plist),
      let id = dictionary["X-Naver-Client-Id"] as? String,
      let password = dictionary["X-Naver-Client-Secret"] as? String
    else {
      print("invalid Plist")
      return
    }

    var url = URLComponents(url: baseURL, resolvingAgainstBaseURL: false)
    let config = URLSessionConfiguration.default
    let session = URLSession(configuration: config)
    let query: [URLQueryItem] = [
      URLQueryItem(name: "query", value: searchName),
      URLQueryItem(name: "display", value: String(display)),
      URLQueryItem(name: "start", value: String(start)),
    ]
    url?.queryItems = query

    var requestURL = URLRequest(url: (url?.url)!) // MARK: -
    requestURL.addValue(id, forHTTPHeaderField: "X-Naver-Client-Id")
    requestURL.addValue(password, forHTTPHeaderField: "X-Naver-Client-Secret")

    URLSession.shared.dataTask(with: requestURL) { data, response, error in
      DispatchQueue.main.async {
        guard
          let response = response as? HTTPURLResponse,
          let data = data
        else {
          completion(.failure(.basic))
          return
        }
        if let movieData = try? JSONDecoder().decode(Movie.self, from: data) {
          completion(.success(movieData))
        } else {
          completion(.failure(.decodeError))
        }
      }
    }
    .resume()
  }
}
