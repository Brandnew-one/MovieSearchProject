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

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    setupNaviView()
    starViewModel.reloadUserDefaults()
    self.starView.tableView.reloadData() // MARK: - Main Thread
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    setupView()
    setupTableView()
  }

  private func setupNaviView() {
    navigationController?.navigationBar.isHidden = true
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

  private func setupTableView() {
    starView.tableView.delegate = self
    starView.tableView.dataSource = self
    starView.tableView.register(MovieCell.self, forCellReuseIdentifier: MovieCell.identifier)
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
    cell.isStar = UserDefaultsManager.shared.containMovieList(items[indexPath.row]) // MARK: - VM
//    cell.index = indexPath.row
    cell.setupCell(item: items[indexPath.row])
    cell.cellDelegate = self
    return cell
  }

  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let vc = MovieDetailViewController()
    vc.movieDetailViewModel.item = starViewModel.items?[indexPath.row]
    self.navigationController?.pushViewController(vc, animated: true)
  }
}

extension StarViewController: CellButtonDelegate {
  func starButtonClicked(_ item: Item?) {
    guard let item = item else { return }
    starViewModel.changeUserDefaults(item)
    DispatchQueue.main.async {
      self.starView.tableView.reloadData()
    }
  }

//  func starButtonClicked(_ index: Int?) {
//    guard
//      let index = index,
//      let item = starViewModel.items?[index]
//    else { return }
//    starViewModel.changeUserDefaults(item)
//    self.starView.tableView.reloadData()
//  }
}

