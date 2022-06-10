//
//  StarView.swift
//  NaverMovie
//
//  Created by Bran on 2022/06/10.
//

import UIKit

import SnapKit

class StarView: UIView {

  let backButton = UIButton()
  let title = UILabel()
  let tableView = UITableView()

  override init(frame: CGRect) {
    super.init(frame: frame)
    setupView()
    setupConstraints()
  }

  required init?(coder: NSCoder) {
    fatalError("StarView ERROR")
  }

  private func setupView() {
    [backButton, title, tableView].forEach { self.addSubview($0) }
    backButton.setImage(UIImage(systemName: "xmark"), for: .normal)
    backButton.setPreferredSymbolConfiguration(
      .init(pointSize: 23, weight: .medium, scale: .default),
      forImageIn: .normal
    )
    backButton.tintColor = .systemGray

    title.text = "즐겨찾기 목록"
    title.font = .systemFont(ofSize: 23, weight: .heavy)
  }

  private func setupConstraints() {
    backButton.snp.makeConstraints { make in
      make.top.equalToSuperview().offset(8)
      make.leading.equalToSuperview().offset(20)
      make.height.equalTo(title)
      make.width.equalTo(backButton.snp.height)
    }

    title.snp.makeConstraints { make in
      make.top.equalToSuperview().offset(8)
      make.centerX.equalToSuperview()
    }

    tableView.snp.makeConstraints { make in
      make.top.equalTo(title.snp.bottom).offset(8)
      make.leading.trailing.bottom.equalToSuperview()
    }
  }

}
