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
    
    //MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .blue
        contentView.addSubview(randomLabel)
        contentView.addSubview(randomImageView)
        contentView.clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    // MARK: - Override methods
    override func layoutSubviews() {
        super.layoutSubviews()
        
        randomLabel.frame = CGRect(x: 0,
                                   y: contentView.frame.size.width-20,
                                   width: contentView.frame.size.width,
                                   height: 20)
        
        randomImageView.frame = CGRect(x: 0,
                                       y: 0,
                                       width: contentView.frame.size.width,
                                       height: contentView.frame.size.width-20)
    }
    
    
    // MARK: - Private methods
    private let randomImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "house")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.backgroundColor = .yellow
        return imageView
    }()
    
    private let randomLabel: UILabel = {
        let label = UILabel()
        label.text = "Фото"
        label.textAlignment = .center
        label.backgroundColor = .green
        return label
    }()
}
