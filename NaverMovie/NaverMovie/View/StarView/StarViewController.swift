//
//  StarViewController.swift
//  NaverMovie
//
//  Created by Bran on 2022/06/10.
//

import UIKit

import SnapKit

class StarViewController: UIViewController {
  let starView = StarView()
  let starViewModel = StarViewModel()

  override func viewDidLoad() {
    super.viewDidLoad()
    setupView()

    starView.tableView.delegate = self
    starView.tableView.dataSource = self
    starView.tableView.register(MovieCell.self, forCellReuseIdentifier: MovieCell.identifier)
  }

  private func setupView() {
    view.backgroundColor = .white
    view.addSubview(starView)
    starView.snp.makeConstraints { make in
      make.edges.equalTo(view.safeAreaLayoutGuide)
    }
    starView.backButton.addTarget(
      self,
      action: #selector(closeButtonClicked),
      for: .touchUpInside
    )
  }

  @objc
  func closeButtonClicked() {
    self.dismiss(animated: true)
  }
}

extension StarViewController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return starViewModel.items?.count ?? 0
  }

  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 90
  }

  func tableView(
    _ tableView: UITableView,
    cellForRowAt indexPath: IndexPath
  ) -> UITableViewCell {
    guard
      let cell = starView.tableView.dequeueReusableCell(
      withIdentifier: MovieCell.identifier,
      for: indexPath
    )as? MovieCell,
      let items = starViewModel.items
    else {
      return UITableViewCell()
    }
    cell.setupCell(item: items[indexPath.row])

    return cell
  }

  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let vc = MovieDetailViewController()
    vc.url = URL(string: (starViewModel.items?[indexPath.row].link) ?? "")
    vc.movieTitle = starViewModel.items?[indexPath.row].title
    self.navigationController?.pushViewController(vc, animated: true)
  }

}
