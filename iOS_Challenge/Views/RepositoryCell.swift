//
//  RepositoryCell.swift
//  iOS_Challenge
//
//  Created by Viraj Thenuwara on 3/10/21.
//

import UIKit

class RepositoryCell: UITableViewCell {

    let profileImage = UIImageView()
    let loginLabel = UILabel()
    let nameLabel = UILabel()
    let descriptionLabel = UILabel()
    let starCountLabel = UILabel()
    let languageLabel = UILabel()
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .white
        self.selectionStyle = .none
        self.contentView.addSubview(profileImage)
        self.contentView.addSubview(loginLabel)
        self.contentView.addSubview(nameLabel)
        self.contentView.addSubview(descriptionLabel)
        self.contentView.addSubview(starCountLabel)
        self.contentView.addSubview(languageLabel)
        addProfileImage()
        addLoginLabel()
        addNameLabel()
        addDescriptionLabel()
        addStarCountLabel()
        addLanguageLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addProfileImage() {
        profileImage.frame = CGRect(x: 5, y: 10, width: 25, height: 25)
        profileImage.roundedCorners(corners: [.allCorners], radius: 25/2)
        
        profileImage.translatesAutoresizingMaskIntoConstraints = false
        let profileImageConstraints = [
            profileImage.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            profileImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5),
            profileImage.widthAnchor.constraint(equalToConstant: 25),
            profileImage.heightAnchor.constraint(equalToConstant: 25)
        ]
        NSLayoutConstraint.activate(profileImageConstraints)
    }
    
    func addLoginLabel() {
        loginLabel.frame = CGRect(x: 5, y: 10, width: boundsWidth, height: 20)
        loginLabel.font = UIFont.boldSystemFont(ofSize: 14)
        loginLabel.textColor = .black
        loginLabel.translatesAutoresizingMaskIntoConstraints = false
        let constraints = [
            loginLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            loginLabel.leadingAnchor.constraint(equalTo: profileImage.trailingAnchor, constant: 5),
            loginLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            loginLabel.heightAnchor.constraint(equalToConstant: 20)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    func addNameLabel() {
        nameLabel.frame = CGRect(x: 5, y: 10, width: boundsWidth, height: 20)
        nameLabel.font = UIFont.boldSystemFont(ofSize: 14)
        nameLabel.textColor = .black
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        let constraints = [
            nameLabel.topAnchor.constraint(equalTo: profileImage.bottomAnchor, constant: 10),
            nameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5),
            nameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            nameLabel.heightAnchor.constraint(equalToConstant: 20)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    func addDescriptionLabel() {
        descriptionLabel.frame = CGRect(x: 5, y: 10, width: boundsWidth, height: 50)
        descriptionLabel.numberOfLines = 0
        descriptionLabel.font = UIFont.systemFont(ofSize: 12)
        descriptionLabel.textColor = .black
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        let constraints = [
            descriptionLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 5),
            descriptionLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5),
            descriptionLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            descriptionLabel.heightAnchor.constraint(equalToConstant: 50)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    func addStarCountLabel() {
        starCountLabel.frame = CGRect(x: 5, y: 10, width: 100, height: 15)
        starCountLabel.font = UIFont.systemFont(ofSize: 12)
        starCountLabel.textColor = .black
        starCountLabel.translatesAutoresizingMaskIntoConstraints = false
        let constraints = [
            starCountLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 10),
            starCountLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5),
            starCountLabel.widthAnchor.constraint(equalToConstant: 100),
            starCountLabel.heightAnchor.constraint(equalToConstant: 15)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    func addLanguageLabel() {
        languageLabel.frame = CGRect(x: 5, y: 10, width: 100, height: 15)
        languageLabel.font = UIFont.systemFont(ofSize: 12)
        languageLabel.textColor = .black
        languageLabel.translatesAutoresizingMaskIntoConstraints = false
        let constraints = [
            languageLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 10),
            languageLabel.leadingAnchor.constraint(equalTo: starCountLabel.trailingAnchor, constant: 50),
            languageLabel.widthAnchor.constraint(equalToConstant: 100),
            languageLabel.heightAnchor.constraint(equalToConstant: 15)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    func setupCell(repository: Node) {
        nameLabel.text = repository.name
        descriptionLabel.text = repository.description
        if let owner = repository.owner {
            loginLabel.text = owner.login
            ImageCache.loadImage(urlString: owner.avatarUrl, userId: owner.id) { (name, image) in
                self.profileImage.image = image
            }
        }
        if let starCount = repository.stargazerCount {
            starCountLabel.text = "⭐️ \(starCount)"
        }
        if let languages = repository.languages {
            if let nodes = languages.nodes {
                if let languge = nodes[0].name {
                    languageLabel.text = "🌕 \(languge)"
                }
            }
        } else {
            languageLabel.text = ""
        }

        
        
        
    }

}
