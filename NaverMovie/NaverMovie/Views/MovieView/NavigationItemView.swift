//
//  NavigationItemView.swift
//  NaverMovie
//
//  Created by Bran on 2022/06/07.
//

import UIKit

import SnapKit

class NavigationLeftItemView: UIView {
  let navigationTitleView = UILabel()

  override init(frame: CGRect) {
    super.init(frame: frame)
    setupView()
    setupConstraints()
  }

  required init?(coder: NSCoder) {
    fatalError("ERROR")
  }

  private func setupView() {
    self.addSubview(navigationTitleView)
    navigationTitleView.font = .systemFont(ofSize: 23, weight: .heavy)
    navigationTitleView.text = "네이버 영화 검색"
    navigationTitleView.textColor = .black
  }

  private func setupConstraints() {
    navigationTitleView.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }
  }
}

class NavigationRightItemView: UIView {
  let navigationButtonView = UIButton()

  override init(frame: CGRect) {
    super.init(frame: frame)
    setupView()
    setupConstraints()
  }

  required init?(coder: NSCoder) {
    fatalError("ERROR")
  }

  private func setupView() {
    self.addSubview(navigationButtonView)
    navigationButtonView.setImage(UIImage(systemName: "star.fill"), for: .normal)
    navigationButtonView.tintColor = .systemYellow

    navigationButtonView.setTitle("즐겨찾기", for: .normal)
    navigationButtonView.setTitleColor(.black, for: .normal)
    navigationButtonView.titleLabel?.font = .systemFont(ofSize: 15, weight: .medium)
//    navigationButtonView.titleEdgeInsets = .init(
//      top: 8, left: 4, bottom: 8, right: 4
//    )

    navigationButtonView.layer.borderWidth = 1
    navigationButtonView.layer.borderColor = UIColor.systemGray6.cgColor
  }

  private func setupConstraints() {
    navigationButtonView.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }
  }
}
