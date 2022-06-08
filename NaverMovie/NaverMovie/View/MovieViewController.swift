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
  let movieViewModel = MovieViewModel()

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
  }

  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    setupView()
    setupNavigationItem()
    setupKeyboard()

    movieView.tableView.delegate = self
    movieView.tableView.dataSource = self
    movieView.textField.delegate = self
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

  private func setupKeyboard() {
    let tabGesture = UITapGestureRecognizer(target: view, action: #selector(view.endEditing(_:)))
    view.addGestureRecognizer(tabGesture)
  }

}

extension MovieViewController: UITableViewDelegate, UITableViewDataSource {

  func tableView(
    _ tableView: UITableView,
    numberOfRowsInSection section: Int
  ) -> Int {
    return movieViewModel.model.items.count
  }

  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 90
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
    cell.setupCell(item: movieViewModel.model.items[indexPath.row])
    return cell
  }
}

extension MovieViewController: UITextFieldDelegate {
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    textField.resignFirstResponder()
    return true
  }

  func textFieldDidEndEditing(_ textField: UITextField) {
    guard let findData = textField.text else { return }
    if !findData.isEmpty {
      findMovieData(findData: findData)
    }
  }

  func findMovieData(findData: String) {
    self.movieViewModel.fetchMovieData(findData) {
      self.movieView.tableView.reloadData()
    }
  }
}
