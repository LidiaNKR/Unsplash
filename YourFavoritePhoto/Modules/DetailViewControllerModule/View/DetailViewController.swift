//
//  DetailViewController.swift
//  Unsplash
//
//  Created by Лидия Ладанюк on 11.06.2023.
//

import UIKit

final class DetailViewController: UIViewController {
    
    // MARK: - Public properties
    var presenter: DetailViewPresenterProtocol!
    
    //MARK: - Private properties
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
        
//        presenter.configure()
        
        view.backgroundColor = .white
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        presenter.setInitialImage()
//    }
    
    // MARK: - Private methods
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

    // MARK: - Extensions
extension DetailViewController: DetailViewProtocol {
    func configure(image: String, createAt: String, description: String) {
        navigationItem.title = createAt
        detailImageView.fetchImage(from: image)
        detailLabel.text = description
        likeButton.imageURL = image
    }
    
    func setInitialImage(image: String) {
        self.likeButton.setInitialImage(imageURL: image)
    }
}



    
