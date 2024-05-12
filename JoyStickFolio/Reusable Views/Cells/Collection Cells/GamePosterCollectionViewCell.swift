//
//  GamePosterCollectionViewCell.swift
//  JoyStickFolio
//
//  Created by Karim Sakr on 11/02/2024.
//

import UIKit

class GamePosterCollectionViewCell: UICollectionViewCell {
    static let identifier = "GamePosterCollectionViewCell"
    
    var game: Game = Game()
    
    private let imagePoster: UIImageView = {
       let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.tintColor = .white
        iv.clipsToBounds = true
        return iv
    }()
    
    private let gameTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Game Title"
        label.numberOfLines = 2
        label.textAlignment = .center
        label.textColor = .gray
        return label
    }()
    
    func configure(with game: Game) {
        
        gameTitleLabel.text = game.name
        self.setupUI()
    }
    
    private func setupUI() {
        
        self.backgroundColor = .systemGray6
        
        addSubview(imagePoster)
        imagePoster.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(gameTitleLabel)
        gameTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imagePoster.topAnchor.constraint(equalTo: self.topAnchor),
            imagePoster.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            imagePoster.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            imagePoster.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
            gameTitleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
            gameTitleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8),
            gameTitleLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8)
        ])
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.imagePoster.image = nil
    }
}
