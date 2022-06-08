//
//  MovieCell.swift
//  NaverMovie
//
//  Created by Bran on 2022/06/07.
//

import UIKit

import SnapKit

class MovieCell: UITableViewCell {
  static let identifier = "MovieCell"

  let movieImageView = UIImageView()
  let movieTitleView = UILabel()
  let movieDirectorView = UILabel()
  let movieActorView = UILabel()
  let movieRateView = UILabel()
  let favoriteButton = UIButton()

  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    setupView()
    setupConstraints()
  }

  required init?(coder: NSCoder) {
    fatalError("ERROR")
  }

  private func setupView() {
    [movieImageView, movieTitleView, movieDirectorView, movieActorView, movieRateView, favoriteButton].forEach { self.addSubview($0) }
    setupText()
    favoriteButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
    favoriteButton.tintColor = .systemYellow
  }

  private func setupText() {
    movieTitleView.font = .systemFont(ofSize: 16, weight: .bold)
    movieTitleView.textColor = .black
    [movieDirectorView, movieActorView, movieRateView].forEach {
      $0.font = .systemFont(ofSize: 13, weight: .regular)
      $0.textColor = .black
    }
  }

  // MARK: - Image Cell의 높이에따라 변하게 설정 해놓은 상태 -> 고정된 cell 사용할거니까
  private func setupConstraints() {
    movieImageView.snp.makeConstraints { make in
      make.top.equalToSuperview().offset(4)
      make.bottom.equalToSuperview().offset(-4)
      make.leading.equalToSuperview().offset(20)
      make.width.equalTo(movieImageView.snp.height).multipliedBy(0.7)
    }

    movieTitleView.snp.makeConstraints { make in
      make.top.equalToSuperview().offset(4)
      make.leading.equalTo(movieImageView.snp.trailing).offset(18)
      make.trailing.equalToSuperview().offset(-18)
    }

    movieDirectorView.snp.makeConstraints { make in
      make.top.equalTo(movieTitleView.snp.bottom).offset(4)
      make.leading.equalTo(movieTitleView)
      make.trailing.equalToSuperview().offset(-18)
    }

    movieActorView.snp.makeConstraints { make in
      make.top.equalTo(movieDirectorView.snp.bottom).offset(4)
      make.leading.equalTo(movieImageView.snp.trailing).offset(18)
      make.trailing.equalToSuperview().offset(-18)
    }

    movieRateView.snp.makeConstraints { make in
      make.top.equalTo(movieActorView.snp.bottom).offset(4)
      make.leading.equalTo(movieImageView.snp.trailing).offset(18)
      make.trailing.equalToSuperview().offset(-18)
//      make.bottom.equalToSuperview().offset(-18)
    }

    favoriteButton.snp.makeConstraints { make in
      make.top.equalToSuperview().offset(4)
      make.trailing.equalToSuperview().offset(-18)
      make.height.width.equalTo(25)
    }
  }

  // MARK: - Setup TableviewCell
  func setupCell(item: Item) {
//    self.movieImageView.image = item.image // TODO: - 캐시 이용
    self.movieTitleView.text = item.title
    self.movieActorView.text = item.actor
    self.movieDirectorView.text = item.director
    self.movieRateView.text = item.userRating
  }

}
