//
//  GamePosterCollectionViewCell.swift
//  JoyStickFolio
//
//  Created by Karim Sakr on 11/02/2024.
//

import UIKit
import SDWebImage

class GamePosterCollectionViewCell: UICollectionViewCell {
    static let identifier = "GamePosterCollectionViewCell"
    
    var game: ExploreModels.ViewModels.Game = ExploreModels.ViewModels.Game()
    
    private let imagePoster: UIImageView = {
       let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.imagePoster.image = nil
    }
}

//MARK: - setup -
extension GamePosterCollectionViewCell {
    
    func configure(with game: ExploreModels.ViewModels.Game) {
        
        if let urlString = game.imageUrl {
            imagePoster.sd_setImage(with: URL(string: "https:" + urlString), placeholderImage: UIImage(named: "JoystickFolioLogo.png"))
            gameTitleLabel.text = nil
        } else {
            imagePoster.image = UIImage(named: "JoystickFolioLogo.png")
            gameTitleLabel.text = game.name
        }
        self.setupUI()
    }
    
    fileprivate
    func setupUI() {
        
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
}
