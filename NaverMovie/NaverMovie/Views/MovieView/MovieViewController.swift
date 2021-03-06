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
  var findData: String?

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    movieView.tableView.reloadData() // MARK: - Star Button
  }

  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    setupView()
    setupNavigationItem()
    setupTableView()
    //    setupKeyboard()
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

    let rightBarButtonItem = NavigationRightItemView()
    rightBarButtonItem.navigationButtonView.addTarget(
      self,
      action: #selector(rightNaviItemClicked),
      for: .touchUpInside
    )
    navigationItem.rightBarButtonItem = UIBarButtonItem(
      customView: rightBarButtonItem
    )
  }

  private func setupTableView() {
    movieView.tableView.delegate = self
    movieView.tableView.dataSource = self
    movieView.textField.delegate = self
    movieView.tableView.register(MovieCell.self, forCellReuseIdentifier: MovieCell.identifier)
  }

  //  private func setupKeyboard() {
  //    let tabGesture = UITapGestureRecognizer(target: view, action: #selector(view.endEditing(_:)))
  //    view.addGestureRecognizer(tabGesture)
  //  }

  @objc
  func rightNaviItemClicked() {
    let vc = UINavigationController(rootViewController: StarViewController())
    vc.modalPresentationStyle = .fullScreen
    self.present(vc, animated: true)
  }

}

extension MovieViewController: UITableViewDelegate, UITableViewDataSource {

  func tableView(
    _ tableView: UITableView,
    numberOfRowsInSection section: Int
  ) -> Int {
    guard let model =  movieViewModel.model else { return 0 }
    return model.items.count
  }

  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 90
  }

  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let vc = MovieDetailViewController()
    vc.movieDetailViewModel.item = movieViewModel.model?.items[indexPath.row]
    self.navigationController?.pushViewController(vc, animated: true)
  }

  func tableView(
    _ tableView: UITableView,
    cellForRowAt indexPath: IndexPath
  ) -> UITableViewCell {
    guard
      let cell = movieView.tableView.dequeueReusableCell(
        withIdentifier: MovieCell.identifier,
        for: indexPath
      ) as? MovieCell,
      let model = movieViewModel.model
    else {
      return UITableViewCell()
    }
    cell.isStar = movieViewModel.checkUserDefaults(model.items[indexPath.row])
    cell.setupCell(item: model.items[indexPath.row])
    cell.cellDelegate = self // MARK: - VM??? ??????????????? ???????????????
    return cell
  }

  func createFooterView() -> UIView {
    let footerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 100))
    let spinner = UIActivityIndicatorView()
    spinner.center = footerView.center
    footerView.addSubview(spinner)
    spinner.startAnimating()
    return footerView
  }

  // MARK: - ???????????? ?????? ?????? ??????!
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    guard movieViewModel.model != nil else { return }
    let offsetY = scrollView.contentOffset.y
    let contentHeight = movieView.tableView.contentSize.height
    let height = scrollView.frame.height

    if offsetY > (contentHeight - height) {
      self.movieView.tableView.tableFooterView = createFooterView()
      DispatchQueue.global().asyncAfter(deadline: .now() + 1) {
        guard let findData = self.findData else { return }
        self.movieViewModel.paginationMovieData(findData) {
          self.movieView.tableView.reloadData()
        }
        DispatchQueue.main.async {
          self.movieView.tableView.tableFooterView = nil
        }
      }
    }
  }
}

extension MovieViewController: CellButtonDelegate {
  // MARK: - UI????????? ?????? ??????????????? ??????????????? ??????????????? (??????) -> item??? ???????????? ?????????, ???????????? ????????? ??????
  func starButtonClicked(_ item: Item?) {
    guard let item = item else { return }
    movieViewModel.changeUserDefaults(item)
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
      self.findData = findData
      findMovieData(findData: findData)
    }
  }

  func findMovieData(findData: String) {
    self.movieViewModel.fetchMovieData(findData) {
      DispatchQueue.main.async {
        self.movieView.tableView.reloadData()
      }
    }
  }
}
