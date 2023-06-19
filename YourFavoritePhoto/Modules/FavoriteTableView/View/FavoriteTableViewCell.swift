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
//    private var favoritePhoto: Results<FavoritePhoto>!
    
    //MARK: - Private properties
    private lazy var favoriteImageView: ImagesImageView = {
        let imageView = ImagesImageView(frame: .zero)
        return imageView
    }()
    
    private lazy var favoriteLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Автор"
        label.backgroundColor = .green
        return label
    }()
    
    //MARK: - Initializers
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(favoriteImageView)
        contentView.addSubview(favoriteLabel)
        favoriteImageViewConstraint()
        favoriteAuthorConstraint()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with photo: FavoritePhoto) {
        favoriteImageView.fetchImage(from: photo.image)
        favoriteLabel.text = photo.description
    }
    
    // MARK: - Private methods
    private func favoriteImageViewConstraint() {
        NSLayoutConstraint.activate([
            favoriteImageView.heightAnchor.constraint(equalToConstant: contentView.frame.height),
            favoriteImageView.widthAnchor.constraint(equalToConstant: (contentView.frame.width / 6) * 2),
            favoriteImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
        ])
    }
    
    private func favoriteAuthorConstraint() {
        NSLayoutConstraint.activate([
            favoriteLabel.heightAnchor.constraint(equalToConstant: contentView.frame.height),
            favoriteLabel.leadingAnchor.constraint(equalTo: favoriteImageView.trailingAnchor, constant: 8),
            favoriteLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8)
        ])
    }
    
}
