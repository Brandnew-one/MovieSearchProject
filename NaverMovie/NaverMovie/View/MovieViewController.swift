//
//  MovieViewController.swift
//  NaverMovie
//
//  Created by Bran on 2022/06/07.
//

import UIKit

import SnapKit

class MovieViewController: UIViewController {

  let movieView = MovieView()

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
  }

  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    setupView()
    setupNavigationItem()

    movieView.tableView.delegate = self
    movieView.tableView.dataSource = self
    movieView.tableView.register(MovieCell.self, forCellReuseIdentifier: MovieCell.identifier)
  }

  private func setupView() {
    view.backgroundColor = .white
    view.addSubview(movieView)
    movieView.snp.makeConstraints { make in
      make.top.equalTo(view.safeAreaLayoutGuide)
      make.leading.trailing.bottom.equalToSuperview()
    }
  }

  private func setupNavigationItem() {
    navigationItem.leftBarButtonItem = UIBarButtonItem(
      customView: NavigationLeftItemView()
    )
    navigationItem.rightBarButtonItem = UIBarButtonItem(
      customView: NavigationRightItemView()
    )
  }
}

extension MovieViewController: UITableViewDelegate, UITableViewDataSource {

  func tableView(
    _ tableView: UITableView,
    numberOfRowsInSection section: Int
  ) -> Int {
    return 2
  }

  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 90
  }

  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    APIService.shared.requestMovie(searchName: "국가") { result in
      if case let .success(val) = result {
        print(result)
      }
    }
  }

  func tableView(
    _ tableView: UITableView,
    cellForRowAt indexPath: IndexPath
  ) -> UITableViewCell {
    guard
      let cell = movieView.tableView.dequeueReusableCell(
        withIdentifier: MovieCell.identifier,
        for: indexPath
      ) as? MovieCell
    else {
      return UITableViewCell()
    }
    cell.movieImageView.image = UIImage(systemName: "person.fill")
    cell.movieTitleView.text = "Test"
    cell.movieActorView.text = "Test: test test"
    cell.movieDirectorView.text = "TEST: test"
    cell.movieRateView.text = "9.9"
    return cell
  }
}
