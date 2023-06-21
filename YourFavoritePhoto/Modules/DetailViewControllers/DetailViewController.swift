//
//  DetailViewController.swift
//  Unsplash
//
//  Created by Лидия Ладанюк on 11.06.2023.
//

import UIKit

final class DetailViewController: UIViewController {
    
    //MARK: - Private properties
    var photo: GalleryElement?
    
    //MARK: - Private properties
    private lazy var imageURL = photo?.urls.regular ?? "No UmageURL"
    
    private var detailImageView: ImagesImageView = {
        let imageView = ImagesImageView(frame: .zero)
        return imageView
    }()
    
    private var likeButton: LikeButton = {
        let button = LikeButton(frame: .zero)
        return button
    }()
    
    private var detailLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .white
        label.textAlignment = .center
        label.textColor = .black
        label.alpha = 0.5
        label.numberOfLines = 0
        return label
    }()
    
    // MARK: - LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()

        detailImageConstraint()
        likeButtonConstraint()
        detailLabelConstraint()
        
        configure(with: photo)
        
        view.backgroundColor = .white
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    // MARK: - Private methods
    private func configure(with photo: GalleryElement?) {
        guard let photo = photo else { return }
        navigationItem.title = photo.createdAt
        detailImageView.fetchImage(from: imageURL)
        detailLabel.text = """
                        Автор: \(photo.user.username ?? "")
                        Страна: \(photo.user.location ?? "")
                        Скачиваний: \(photo.downloads ?? 0)
                        """
        likeButton.setInitialImage(imageURL: imageURL)
        likeButton.imageURL = imageURL
    }
    
    private func detailImageConstraint() {
        view.addSubview(detailImageView)
        NSLayoutConstraint.activate([
            detailImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            detailImageView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0),
            detailImageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0),
            detailImageView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0)
        ])
    }
    
    private func likeButtonConstraint() {
        view.addSubview(likeButton)
        NSLayoutConstraint.activate([
            likeButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            likeButton.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -8),
            likeButton.heightAnchor.constraint(equalToConstant: 30),
            likeButton.widthAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    private func detailLabelConstraint() {
        view.addSubview(detailLabel)
        NSLayoutConstraint.activate([
            detailLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0),
            detailLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0),
            detailLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0)
        ])
    }
}



    
