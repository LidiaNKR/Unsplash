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
    
    //MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        randomImageViewConstraint()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        randomImageView.image = nil
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with photo: String?) {
        randomImageView.fetchImage(from: photo)
    }

     // MARK: - Private methods
    private func randomImageViewConstraint() {
        contentView.addSubview(randomImageView)
        NSLayoutConstraint.activate([
            randomImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            randomImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0),
            randomImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
            randomImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0)
        ])
    }
}
