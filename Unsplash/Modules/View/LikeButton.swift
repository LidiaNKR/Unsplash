//
//  LikeButton.swift
//  Unsplash
//
//  Created by Лидия Ладанюк on 13.06.2023.
//

import UIKit

final class LikeButton: UIButton {
    
    //MARK: - Private properties
    ///Избранное фото? - да/нет
    private var isFavotitePhoto: Bool = true
    
    //MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.addTarget(self, action: #selector(pressed), for: .touchUpInside)
        setImage(named: "UnFavImage")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Methods
    ///Изменение Image "избранное" по нажатию
    @objc private func pressed() {
        if isFavotitePhoto {
            setImage(named: "FavImage")
            isFavotitePhoto = false
        } else {
            setImage(named: "UnFavImage")
            isFavotitePhoto = true
        }
    }
    
    ///Установка Image в UIButton
    private func setImage(named: String) {
        self.setImage(UIImage(named: named), for: .normal)
    }
}

