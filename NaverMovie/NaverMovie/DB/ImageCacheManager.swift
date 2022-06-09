//
//  ImageCacheManager.swift
//  NaverMovie
//
//  Created by Bran on 2022/06/09.
//

import UIKit

class ImageCacheManager {
  static let shared = NSCache<NSString, UIImage>()
  private init() { }
}

