//
//  RandomCollectionViewCell.swift
//  Unsplash
//
//  Created by Лидия Ладанюк on 12.06.2023.
//

import UIKit

final class RandomCollectionViewCell: UICollectionViewCell {
    
    //MARK: - Static properties
    static let identifier = "RandomCollectionViewCell"
    
    //MARK: - Private properties
    private let randomImageView: ImagesImageView = {
        let imageView = ImagesImageView(frame: .zero)
        return imageView
    }()
    
    private let randomAuthorLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Фото"
        label.textAlignment = .center
        label.backgroundColor = .green
        return label
    }()
    
    //MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .blue
        contentView.addSubview(randomAuthorLabel)
        contentView.addSubview(randomImageView)
//        contentView.clipsToBounds = true
        randomImageViewConstraint()
        randomAuthorConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with photo: GalleryElement?) {
        randomImageView.fetchImage(from: photo?.urls.regular ?? "")
        randomAuthorLabel.text = photo?.description
    }

    // MARK: - Private methods
    private func randomImageViewConstraint() {
        NSLayoutConstraint.activate([
        randomImageView.heightAnchor.constraint(equalToConstant: (contentView.frame.height / 6) * 5),
        randomImageView.widthAnchor.constraint(equalToConstant: contentView.frame.width),
        randomImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0)
        ])
    }
    
    private func randomAuthorConstraint() {
        NSLayoutConstraint.activate([
//        randomAuthorLabel.heightAnchor.constraint(equalToConstant: (contentView.frame.height / 6) * 1),
        randomAuthorLabel.widthAnchor.constraint(equalToConstant: contentView.frame.width),
        randomAuthorLabel.topAnchor.constraint(equalTo: randomImageView.bottomAnchor, constant: 0),
        randomAuthorLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0)
        ])
    }
}
