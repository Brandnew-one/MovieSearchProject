//
//  APIService.swift
//  NaverMovie
//
//  Created by Bran on 2022/06/08.
//

import UIKit

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
    let querry: [URLQueryItem] = [
      URLQueryItem(name: "query", value: searchName),
      URLQueryItem(name: "display", value: String(display)),
      URLQueryItem(name: "start", value: String(start)),
    ]
    url?.queryItems = querry

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

extension UIImageView {
  func setImageUrl(_ url: String) {
    if url.isEmpty {
      self.image = UIImage()
    } else {
      DispatchQueue.global(qos: .background).async {
        /// cache할 객체의 key값을 string으로 생성
        let cachedKey = NSString(string: url)

        /// cache된 이미지가 존재하면 그 이미지를 사용 (API 호출안하는 형태)
        if let cachedImage = ImageCacheManager.shared.object(forKey: cachedKey) {
          DispatchQueue.main.async {
            self.image = cachedImage
            return
          }
        }

        guard let url = URL(string: url) else { return }
        URLSession.shared.dataTask(with: url) { (data, result, error) in
          guard error == nil else {
            DispatchQueue.main.async { [weak self] in
              self?.image = UIImage()
            }
            return
          }

          DispatchQueue.main.async { [weak self] in
            if let data = data,
               let image = UIImage(data: data) {
              /// 캐싱
              ImageCacheManager.shared.setObject(image, forKey: cachedKey)
              self?.image = image
            }
          }
        }.resume()
      }
    }
  }
}
