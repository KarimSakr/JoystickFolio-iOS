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
        return label
    }()
    
    func configure(with game: Game) {
        
        gameTitleLabel.text = game.name
//        do {
//                let data = try await downloadImageData(from: url)
//                let image = UIImage(data: data)
//                // Display the image
//            } catch {
//                print("Error: \(error.localizedDescription)")
//            }
        self.setupUI()
    }
    
    private func setupUI() {
        gameTitleLabel.text = game.name
        self.backgroundColor = .systemRed
        
        addSubview(imagePoster)
        imagePoster.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imagePoster.topAnchor.constraint(equalTo: self.topAnchor),
            imagePoster.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            imagePoster.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            imagePoster.trailingAnchor.constraint(equalTo: self.trailingAnchor),
        ])
    }
    
    private func downloadImageData(from url: URL) async throws -> Data {
        let request = URLRequest(url: url)
        let (data, _) = try await URLSession.shared.data(for: request)
        return data
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.imagePoster.image = nil
    }
}
