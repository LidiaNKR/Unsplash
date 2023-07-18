//
//  FavoriteTableViewCell.swift
//  Unsplash
//
//  Created by Лидия Ладанюк on 12.06.2023.
//

import UIKit

final class FavoriteTableViewCell: UITableViewCell {
    
    //MARK: - Static properties
    static let identifier = "FavoriteTableViewCell"
    
    //MARK: - Private properties
    private lazy var favoriteImageView: ImagesImageView = {
        let imageView = ImagesImageView(frame: .zero)
        return imageView
    }()
    
    private lazy var favoriteLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    //MARK: - Initializers
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        favoriteImageViewConstraint()
        favoriteAuthorConstraint()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public methods
    func configure(photo: String?, userName: String?) {
        favoriteImageView.fetchImage(from: photo)
        favoriteLabel.text = userName
    }
    
    // MARK: - Private methods
    private func favoriteImageViewConstraint() {
        contentView.addSubview(favoriteImageView)
        NSLayoutConstraint.activate([
            favoriteImageView.widthAnchor.constraint(equalToConstant: (contentView.frame.width / 5) * 2),
            favoriteImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4),
            favoriteImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -4),
            favoriteImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
        ])
    }
    
    private func favoriteAuthorConstraint() {
        contentView.addSubview(favoriteLabel)
        NSLayoutConstraint.activate([
            favoriteLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4),
            favoriteLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -4),
            favoriteLabel.leadingAnchor.constraint(equalTo: favoriteImageView.trailingAnchor, constant: 8),
            favoriteLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8)
        ])
    }
}
