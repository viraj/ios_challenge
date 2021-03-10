//
//  HeaderView.swift
//  iOS_Challenge
//
//  Created by Viraj Thenuwara on 3/9/21.
//

import UIKit

class HeaderView: UIView {

    
    let profileImage = UIImageView()
    let nameLabel = UILabel()
    let loginLabel = UILabel()
    let emailLabel = UILabel()
    let followerLabel = UILabel()
    let followingLabel = UILabel()
    
    var currentUser:User?
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
    }
    
    convenience init() {
        self.init(frame: CGRect.zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: boundsWidth, height: 24))
        titleLabel.text = "Profile"
        titleLabel.textAlignment = .center
        titleLabel.textColor = .black
        self.addSubview(titleLabel)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        let constraints = [
            titleLabel.topAnchor.constraint(equalTo: self.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: 24)
        ]
        NSLayoutConstraint.activate(constraints)
        
        profileImage.frame = CGRect(x: 5, y: 50, width: 100, height: 100)
        profileImage.roundedCorners(corners: [.allCorners], radius: 50)
        self.addSubview(profileImage)
        
        profileImage.translatesAutoresizingMaskIntoConstraints = false
        let profileImageConstraints = [
            profileImage.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            profileImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5),
            profileImage.widthAnchor.constraint(equalToConstant: 100),
            profileImage.heightAnchor.constraint(equalToConstant: 100)
        ]
        NSLayoutConstraint.activate(profileImageConstraints)
        
        nameLabel.frame = CGRect(x: 115, y: 60, width: boundsWidth, height: 30)
        nameLabel.font = UIFont.boldSystemFont(ofSize: 24)
        nameLabel.textColor = .black
        self.addSubview(nameLabel)
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        let nameLabelConstraints = [
            nameLabel.bottomAnchor.constraint(equalTo: profileImage.centerYAnchor, constant: 5),
            nameLabel.leadingAnchor.constraint(equalTo: profileImage.trailingAnchor, constant: 5),
            nameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            nameLabel.heightAnchor.constraint(equalToConstant: 30)
        ]
        NSLayoutConstraint.activate(nameLabelConstraints)
        
        
        loginLabel.frame = CGRect(x: 115, y: 90, width: boundsWidth, height: 20)
        loginLabel.font = UIFont.boldSystemFont(ofSize: 14)
        loginLabel.textColor = .black
        self.addSubview(loginLabel)
        
        loginLabel.translatesAutoresizingMaskIntoConstraints = false
        let loginLabelConstraints = [
            loginLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor),
            loginLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            loginLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            loginLabel.heightAnchor.constraint(equalToConstant: 20)
        ]
        NSLayoutConstraint.activate(loginLabelConstraints)
        
        
        emailLabel.frame = CGRect(x: 5, y: 155, width: boundsWidth, height: 20)
        emailLabel.font = UIFont.boldSystemFont(ofSize: 14)
        emailLabel.textColor = .black
        self.addSubview(emailLabel)
        
        emailLabel.translatesAutoresizingMaskIntoConstraints = false
        let emailLabelConstraints = [
            emailLabel.topAnchor.constraint(equalTo: profileImage.bottomAnchor, constant: 5),
            emailLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5),
            emailLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            emailLabel.heightAnchor.constraint(equalToConstant: 20)
        ]
        NSLayoutConstraint.activate(emailLabelConstraints)
        
        
        followerLabel.frame = CGRect(x: 5, y: 175, width: boundsWidth, height: 20)
        followerLabel.font = UIFont.systemFont(ofSize: 14)
        followerLabel.textColor = .black
        followerLabel.sizeToFit()
        self.addSubview(followerLabel)
        
        
        followerLabel.translatesAutoresizingMaskIntoConstraints = false
        let followerLabelConstraints = [
            followerLabel.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 10),
            followerLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5),
            followerLabel.heightAnchor.constraint(equalToConstant: 20)
        ]
        NSLayoutConstraint.activate(followerLabelConstraints)
        
        followingLabel.frame = CGRect(x: 100, y: 175, width: boundsWidth, height: 20)
        followingLabel.font = UIFont.systemFont(ofSize: 14)
        followingLabel.textColor = .black
        self.addSubview(followingLabel)
        
        followingLabel.translatesAutoresizingMaskIntoConstraints = false
        let followingLabelConstraints = [
            followingLabel.topAnchor.constraint(equalTo: followerLabel.topAnchor),
            followingLabel.leadingAnchor.constraint(equalTo: followerLabel.trailingAnchor, constant: 50),
            followingLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            followingLabel.heightAnchor.constraint(equalToConstant: 20)
        ]
        NSLayoutConstraint.activate(followingLabelConstraints)
        
        self.frame = CGRect(x: 0, y: 0, width: boundsWidth, height: 200)
        
        if let user = currentUser {
            ImageCache.loadImage(urlString: user.avatarUrl, userId: "\(user.id)_400") { (name, image) in
                self.profileImage.image = image
            }
            nameLabel.text = user.name
            loginLabel.text = user.login
            emailLabel.text = user.email
            let numberOfFollwers = user.followers?.totalCount ?? 0
            followerLabel.text = "\(numberOfFollwers) followers"
            
            let numberOfFollowings = user.following?.totalCount ?? 0
            followingLabel.text = "\(numberOfFollowings) following"
            
        }
    }
}
