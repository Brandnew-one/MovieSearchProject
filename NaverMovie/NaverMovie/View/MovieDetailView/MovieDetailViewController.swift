//
//  MovieDetailViewController.swift
//  NaverMovie
//
//  Created by Bran on 2022/06/10.
//

import UIKit
import WebKit

import SnapKit

class MovieDetailViewController: UIViewController {
  var url: URL? = nil
  var movieTitle: String? = nil
  private let webView = WKWebView()

  override func viewDidLoad() {
    super.viewDidLoad()
    setupNaviItems()
    setupWebView()
  }

  private func setupNaviItems() {
    self.navigationController?.navigationBar.tintColor = .black
    navigationItem.title = movieTitle
    navigationItem.leftBarButtonItem = UIBarButtonItem(
      image: UIImage(systemName: "chevron.backward"),
      style: .plain,
      target: self,
      action: #selector(backButtonClicked)
    )
  }

  private func setupWebView() {
    view.backgroundColor = .white
    view.addSubview(webView)
    webView.snp.makeConstraints { make in
      make.edges.equalTo(view.safeAreaLayoutGuide)
    }
    webViewConfig()
  }

  private func webViewConfig() {
    guard let url = url else { return }
    let request = URLRequest(url: url)
    webView.configuration.defaultWebpagePreferences.allowsContentJavaScript = true
    webView.load(request)
  }

  @objc
  func backButtonClicked() {
    self.navigationController?.popViewController(animated: true)
  }

}
