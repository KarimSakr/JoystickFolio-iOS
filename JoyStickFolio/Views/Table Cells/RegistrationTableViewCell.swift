//
//  RegistrationTableViewCell.swift
//  JoyStickFolio
//
//  Created by Karim Sakr on 10/12/2023.
//

import UIKit

class RegistrationTableViewCell: UITableViewCell {
    
    static let identifier = "RegistrationTableViewCell"
    
    let leftLabel = UILabel()
    let rightLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        // Setup UI elements and constraints
        setupUI()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
            // Configure leftLabel
            leftLabel.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview(leftLabel)

            // Configure rightLabel
            rightLabel.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview(rightLabel)

            // Add constraints as needed
            NSLayoutConstraint.activate([
                leftLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
                leftLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),

                rightLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
                rightLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
            ])
        }



}
