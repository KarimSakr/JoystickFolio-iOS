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
    
    lazy var containerView : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        view.clipsToBounds = true
        return view
    }()
    
    lazy var imagePoster: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFill
        image.tintColor = .white
        image.clipsToBounds = true
        image.addBottomGradient(color: .black, alpha: 1)
        return image
    }()
    
    lazy var gameTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .left
        label.textColor = .lightGray
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
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
        } else {
            imagePoster.image = UIImage(named: "JoystickFolioLogo.png")
            gameTitleLabel.text = game.name
        }
        self.setUpUI()
    }
    
    fileprivate
    func setUpUI() {
        
        self.backgroundColor = .systemGray6
        self.layer.cornerRadius = 8
        self.clipsToBounds = true
        
        self.addSubview(containerView)
        containerView.addSubview(imagePoster)
        containerView.addSubview(gameTitleLabel)
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: self.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            containerView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            containerView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
            imagePoster.topAnchor.constraint(equalTo: containerView.topAnchor),
            imagePoster.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            imagePoster.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            imagePoster.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            
            gameTitleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 8),
            gameTitleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -8),
            gameTitleLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -8)
        ])
    }
}
