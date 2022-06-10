//
//  StarViewController.swift
//  NaverMovie
//
//  Created by Bran on 2022/06/10.
//

import UIKit

import SnapKit

// MARK: - Modal 방식으로 구현
class StarViewController: UIViewController {
  let starView = StarView()

  override func viewDidLoad() {
    super.viewDidLoad()
    setupView()
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
