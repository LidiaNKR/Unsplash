//
//  DetailViewController.swift
//  Unsplash
//
//  Created by Лидия Ладанюк on 11.06.2023.
//

import UIKit

final class DetailViewController: UIViewController {
    
    //MARK: - Private properties
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.backgroundColor = .blue
        scrollView.alwaysBounceVertical = true
        return scrollView
    }()
    
    private let contentView: UIView = {
        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        return contentView
    }()
    
    private let detailImageView: ImagesImageView = {
        let imageView = ImagesImageView(frame: .zero)
        return imageView
    }()
    
    private let likeButton: LikeButton = {
        let button = LikeButton()
        return button
    }()
    
    private let detailLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Описание"
        label.numberOfLines = 0
        label.backgroundColor = .green
        return label
    }()
    
    // MARK: - LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(detailImageView)
        view.addSubview(likeButton)
        contentView.addSubview(detailLabel)
        
        scrollViewConstraint()
        contentViewConstraint()
        detailImageConstraint()
        likeButtonConstraint()
        detailLabelConstraint()
        
        view.backgroundColor = .gray
    }
    
    // MARK: - Private methods
    private func scrollViewConstraint() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
    
    private func contentViewConstraint() {
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
    }
    
    private func detailImageConstraint() {
        NSLayoutConstraint.activate([
        detailImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 0),
        detailImageView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: 0),
        detailImageView.heightAnchor.constraint(equalToConstant: view.frame.height * 0.3),
        detailImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0)
        ])
    }

    private func likeButtonConstraint() {
        NSLayoutConstraint.activate([
        likeButton.topAnchor.constraint(equalTo: detailImageView.topAnchor, constant: 5),
        likeButton.rightAnchor.constraint(equalTo: detailImageView.rightAnchor, constant: -5),
        likeButton.heightAnchor.constraint(equalToConstant: 30),
        likeButton.widthAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    private func detailLabelConstraint() {
        NSLayoutConstraint.activate([
        detailLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
        detailLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16),
        detailLabel.topAnchor.constraint(equalTo: detailImageView.bottomAnchor, constant: 16),
        detailLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
        ])
    }
}



    
