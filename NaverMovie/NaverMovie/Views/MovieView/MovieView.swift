//
//  MovieView.swift
//  NaverMovie
//
//  Created by Bran on 2022/06/07.
//

import UIKit

import SnapKit

class MovieView: UIView {
  public let lineView = UIView() // TODO: - UIKit navi option 있는지 확인 해보기
  public let textField = UITextField()
  public let tableView = UITableView()

  override init(frame: CGRect) {
    super.init(frame: frame)
    setupView()
    setupConstraints()
  }

  required init?(coder: NSCoder) {
    fatalError("ERROR")
  }

  private func setupView() {
    [lineView, textField, tableView].forEach {
      self.addSubview($0)
    }
    lineView.backgroundColor = .systemGray6
    textField.borderStyle = .roundedRect
  }

  private func setupConstraints() {
    lineView.snp.makeConstraints { make in
      make.top.leading.trailing.equalToSuperview()
      make.height.equalTo(1)
    }

    textField.snp.makeConstraints { make in
      make.top.equalToSuperview().offset(18)
      make.leading.equalToSuperview().offset(18)
      make.trailing.equalToSuperview().offset(-18)
    }

    tableView.snp.makeConstraints { make in
      make.top.equalTo(textField.snp.bottom).offset(18)
      make.leading.trailing.bottom.equalToSuperview()
    }
  }
}
