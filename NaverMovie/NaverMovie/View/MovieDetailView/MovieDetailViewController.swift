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
  var item: Item? = nil

  private let movieDetailView = MovieDetailView()

  override func viewDidLoad() {
    super.viewDidLoad()
    setupTableView()
    setupNaviItems()
    setupWebView()
  }

  private func setupTableView() {
    movieDetailView.tableView.alwaysBounceVertical = false
    movieDetailView.tableView.allowsSelection = false
    movieDetailView.tableView.delegate = self
    movieDetailView.tableView.dataSource = self
    movieDetailView.tableView.register(MovieCell.self, forCellReuseIdentifier: MovieCell.identifier)
  }

  private func setupNaviItems() {
    let font: UIFont = .systemFont(ofSize: 20, weight: .heavy)
    let naviFont = [NSAttributedString.Key.font: font]
    self.navigationController?.navigationBar.isHidden = false
    self.navigationController?.navigationBar.tintColor = .black
    self.navigationController?.navigationBar.titleTextAttributes = naviFont
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
    view.addSubview(movieDetailView)
    movieDetailView.snp.makeConstraints { make in
      make.edges.equalTo(view.safeAreaLayoutGuide)
    }
    webViewConfig()
  }

  private func webViewConfig() {
    guard let url = url else { return }
    let request = URLRequest(url: url)
    movieDetailView.webView.configuration.defaultWebpagePreferences.allowsContentJavaScript = true
    movieDetailView.webView.load(request)
  }

  @objc
  func backButtonClicked() {
    self.navigationController?.popViewController(animated: true)
  }
}

extension MovieDetailViewController: UITableViewDelegate, UITableViewDataSource {

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if item != nil {
      return 1
    } else { return 0 }
  }

  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 90
  }

  func tableView(
    _ tableView: UITableView,
    cellForRowAt indexPath: IndexPath
  ) -> UITableViewCell {
    guard
      let cell = movieDetailView.tableView.dequeueReusableCell(
      withIdentifier: MovieCell.identifier,
      for: indexPath
    ) as? MovieCell,
      let item = item
    else {
      return UITableViewCell()
    }
    cell.isStar = UserDefaultsManager.shared.containMovieList(item)
    cell.favoriteButton.addTarget(self, action: #selector(favoriteButtonClicked), for: .touchUpInside)
    cell.setupCell(item: item)
    return cell
  }

  @objc
  func favoriteButtonClicked() {
    guard let item = item else { return }
    if UserDefaultsManager.shared.containMovieList(item) {
      UserDefaultsManager.shared.removeMovieListItem(item)
    } else {
      UserDefaultsManager.shared.appendMovieListItem(item)
    }
  }
}

