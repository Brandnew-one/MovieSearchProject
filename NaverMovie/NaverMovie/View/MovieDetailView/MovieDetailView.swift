//
//  MovieDetailView.swift
//  NaverMovie
//
//  Created by Bran on 2022/06/10.
//

import UIKit
import WebKit

import SnapKit

class MovieDetailView: UIView {
  let tableView = UITableView()
  let webView = WKWebView()

  override init(frame: CGRect) {
    super.init(frame: frame)
    setupView()
    setupConstraints()
  }

  required init?(coder: NSCoder) {
    fatalError("DetailView ERROR")
  }

  private func setupView() {
    [tableView, webView].forEach { self.addSubview($0) }
    
  }

  private func setupConstraints() {
    
  }

}
