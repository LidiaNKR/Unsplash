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
    private let favoriteImageView: ImagesImageView = {
        let imageView = ImagesImageView(frame: .zero)
        return imageView
    }()
    
    private let favoriteLabel: UILabel = {
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
        createLayoutConstraint()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private methods
    private func createLayoutConstraint() {
        let viewsVFL = ["image" : favoriteImageView, "label": favoriteLabel]
        let metrics = ["size": contentView.frame.height]
        
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-[image]-|",
                                                                  options: [],
                                                                  metrics: metrics,
                                                                  views: viewsVFL))
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[image(100)]-|",
                                                                  options: [],
                                                                  metrics: metrics,
                                                                  views: viewsVFL))
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-[label]-|",
                                                                  options: [],
                                                                  metrics: nil,
                                                                  views: viewsVFL))
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[image]-[label]-|",
                                                                  options: [],
                                                                  metrics: nil,
                                                                  views: viewsVFL))
    }
    
}
