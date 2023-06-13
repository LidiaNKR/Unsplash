//
//  ImagesImageView.swift
//  Unsplash
//
//  Created by Лидия Ладанюк on 13.06.2023.
//

import UIKit

final class ImagesImageView: UIImageView {
    
    // MARK: - Public properties
    private let activityIndicator = UIActivityIndicatorView(style: .medium)
    
    //MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        image = UIImage(systemName: "house")
        contentMode = .scaleAspectFit
        clipsToBounds = true
        backgroundColor = .yellow
        addSubview(activityIndicator)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private methods
    ///Настройка activityIndicator
    private func activityIndicator(_ isHidden: Bool) {
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        if !isHidden {
            activityIndicator.startAnimating()
            activityIndicator.hidesWhenStopped = true
        } else {
            activityIndicator.stopAnimating()
        }
    }
}
