//
//  ContactViewTableViewCell.swift
//  AppExntesions
//
//  Created by Mani on 24/01/25.
//

import UIKit
class ContactViewTableViewCell: UITableViewCell {
    var titleLabel: UILabel!
    var subtitleLabel: UILabel!
    var checkBox: UIImageView!
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        // Initialize custom views
        titleLabel = UILabel()
        subtitleLabel = UILabel()
        checkBox = UIImageView()
        
        // Set properties for the labels
        titleLabel.font = UIFont.boldSystemFont(ofSize: 16)
        subtitleLabel.font = UIFont.systemFont(ofSize: 12)
        subtitleLabel.textColor = .gray
        
        // Add the labels to the content view
        contentView.addSubview(titleLabel)
        contentView.addSubview(subtitleLabel)
        contentView.addSubview(checkBox)
        
        // Set up constraints (using Auto Layout)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        checkBox.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            checkBox.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            checkBox.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            checkBox.widthAnchor.constraint(equalToConstant: 20),
            checkBox.heightAnchor.constraint(equalToConstant: 20),
                        
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
            subtitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            subtitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            subtitleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
        
    }
    
    func configureCell(userData: UserData) {
        
        titleLabel.text = userData.name
        subtitleLabel.text = userData.mobile
        
        checkBox.image = !userData.selected ? UIImage(systemName: "checkmark.square"): UIImage(systemName: "checkmark.square.fill")
        checkBox.tintColor = !userData.selected ? .gray : .blue
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
