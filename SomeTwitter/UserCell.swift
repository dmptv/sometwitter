//
//  UserCell.swift
//  SomeTwitter
//
//  Created by Kanat A on 15/03/2017.
//  Copyright © 2017 ak. All rights reserved.
//

import UIKit

class UserCell: DatasourceCell {
    
    // получаем data source для UserCell
    override var datasourceItem: Any? {
        didSet {
            guard let user = datasourceItem as? User else {return}
            
            nameLabel.text = user.name
            usernameLabel.text = user.username
            bioTextView.text = user.bioText
            profileImageView.loadImage(urlString: user.profileImageUrl)
        }
    }
    
    let profileImageView: CachedImageView = {
        let iv = CachedImageView()
        iv.image = #imageLiteral(resourceName: "profile_image")
        iv.contentMode = .scaleAspectFill
        iv.layer.cornerRadius = 5
        iv.clipsToBounds = true
        return iv
    }()
    
    let nameLabel: UILabel = {
        let lb = UILabel()
        lb.text = "Nate Diaz"
        lb.font = .boldSystemFont(ofSize: 16)
        return lb
    }()
    
    let usernameLabel: UILabel = {
        let lb = UILabel()
        lb.text = "@username"
        lb.font = .systemFont(ofSize: 14)
        lb.textColor = UIColor(r: 130, g: 130, b: 130)
        return lb
    }()
    
    let bioTextView: UITextView = {
        let tv = UITextView()
        tv.text = "The collapsible table view must somehow keep track of which sections are collapsed (contracted) and which of them are expanded."
        tv.font = .systemFont(ofSize: 15)
        tv.backgroundColor = .clear
        tv.isEditable = false
        tv.isSelectable = false 
        return tv
    }()
    

    let followButton: UIButton = {
        let fb = UIButton()
        fb.layer.cornerRadius = 5
        fb.layer.borderColor = twitterBlue.cgColor
        fb.layer.borderWidth = 1
        fb.setTitle("Follow", for: .normal)
        fb.setTitleColor(twitterBlue, for: .normal)
        fb.titleLabel?.font = .boldSystemFont(ofSize: 14)
        fb.setImage(#imageLiteral(resourceName: "follow"), for: .normal)
        fb.imageView?.contentMode = .scaleAspectFit
        fb.imageEdgeInsets = UIEdgeInsets(top: 0, left: -8, bottom: 0, right: 0)
        fb.titleEdgeInsets = UIEdgeInsets(top: 0, left: -2, bottom: 0, right: 0)
        return fb
    }()
    
    override func setupViews() {
        super.setupViews()
        
        backgroundColor = .white
        
        separatorLineView.isHidden = false
        separatorLineView.backgroundColor = UIColor(r: 230, g: 230, b: 230)
        
        addSubview(profileImageView)
        addSubview(nameLabel)
        addSubview(usernameLabel)
        addSubview(bioTextView)
        addSubview(followButton)
        
        profileImageView.anchor(topAnchor, left: leftAnchor, bottom: nil, right: nil, topConstant: 12, leftConstant: 12, bottomConstant: 0, rightConstant: 0, widthConstant: 50, heightConstant: 50)
        
        nameLabel.anchor(profileImageView.topAnchor, left: profileImageView.rightAnchor, bottom: nil, right: followButton.leftAnchor, topConstant: 0, leftConstant: 8 , bottomConstant: 0, rightConstant: 12, widthConstant: 0, heightConstant: 20 )
        
        usernameLabel.anchor(nameLabel.bottomAnchor, left: nameLabel.leftAnchor, bottom: nil, right: nameLabel.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 20)
        
        bioTextView.anchor(usernameLabel.bottomAnchor, left: usernameLabel.leftAnchor, bottom: bottomAnchor, right: rightAnchor, topConstant: -4, leftConstant: -4 , bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        followButton.anchor(topAnchor, left: nil, bottom: nil, right: rightAnchor, topConstant: 12, leftConstant: 0, bottomConstant: 0, rightConstant: 12, widthConstant: 120, heightConstant: 34)
    }
}












