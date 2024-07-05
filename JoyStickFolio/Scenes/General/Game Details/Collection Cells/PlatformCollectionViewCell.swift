//
//  PlatformCollectionViewCell.swift
//  JoyStickFolio
//
//  Created by Karim Sakr on 17/06/2024.
//

import UIKit

class PlatformCollectionViewCell: UICollectionViewCell {
    static let identifier = "PlatformCollectionViewCell"
        
    lazy var platformTitleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var cellBackground: UIView = {
        let view = UIView()
        view.backgroundColor = .purpleApp
        view.layer.cornerRadius = 25
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
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
    }
}

//MARK: - setup -
extension PlatformCollectionViewCell {
    
    func configure(platform: GameDetailsModels.ViewModels.Platform) {
        platformTitleLabel.text = platform.name
        self.setupUI()
    }
    
    fileprivate
    func setupUI() {
        
        addSubview(cellBackground)
        cellBackground.addSubview(platformTitleLabel)
        
        NSLayoutConstraint.activate([
           
            cellBackground.widthAnchor.constraint(equalToConstant: 150),
            cellBackground.heightAnchor.constraint(equalToConstant: 50),
            
            platformTitleLabel.centerXAnchor.constraint(equalTo: cellBackground.centerXAnchor),
            platformTitleLabel.centerYAnchor.constraint(equalTo: cellBackground.centerYAnchor),
        
        ])
    }
}
