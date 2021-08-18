//
//  FeedListTableViewCell.swift
//  HackathonProject
//
//  Created by Swati Yadav on 17/08/21.
//

import UIKit

class FeedListTableViewCell: UITableViewCell {
    
    // Height constraint for managing dynamic height
    var feedImageViewHeightConstraint: NSLayoutConstraint? = nil
    var additionalSeparator: UIView = UIView()

    private lazy var feedImageView: UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFill // image will never be strecthed vertially or horizontally
        img.translatesAutoresizingMaskIntoConstraints = false // enable autolayout
        img.layer.cornerRadius = 2.0
        img.clipsToBounds = true
        img.frame.size = CGSize.init(width: UIScreen.main.bounds.width, height: 50)
        addConstraints(image: img)
        return img
    }()
    
    func addConstraints(image: UIImageView) {
        if feedImageViewHeightConstraint == nil {
            feedImageViewHeightConstraint = NSLayoutConstraint(item: image,
                                                               attribute: .height,
                                                               relatedBy: .equal,
                                                               toItem: nil,
                                                               attribute: .notAnAttribute,
                                                               multiplier: 1,
                                                               constant: CGFloat(AppConstants.feedImageHeight))
        }
        
        feedImageViewHeightConstraint?.isActive = true
        feedImageViewHeightConstraint?.priority = UILayoutPriority(rawValue: 754)
    }
    
    private lazy var feedTitleLabel: UILabel = {
        let label = setUpLabel(fontSize: 16, textColor: .black)
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var scoreLabel: UILabel = {
        return setUpLabel(fontSize: 14, textColor: .gray)
    }()
    
    private lazy var commentCountLabel: UILabel = {
        return setUpLabel(fontSize: 14, textColor: .gray)
    }()
    
    func setUpLabel(fontSize: CGFloat, textColor: UIColor) -> UILabel {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: fontSize)
        label.textColor = textColor
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureContents()
        configureConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    // Configure contents & constraints
    private func configureContents() {
        self.selectionStyle = .none
        self.contentView.addSubview(feedImageView)
        self.contentView.addSubview(feedTitleLabel)
        self.contentView.addSubview(scoreLabel)
        self.contentView.addSubview(commentCountLabel)
        self.createSeparator()
    }
    
    func createSeparator() {
        self.additionalSeparator.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(self.additionalSeparator)
    }
    
        
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            feedTitleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
            feedTitleLabel.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
            feedTitleLabel.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor),
        ])
        
        NSLayoutConstraint.activate([
            feedImageView.topAnchor.constraint(equalTo: feedTitleLabel.bottomAnchor, constant: 30),
            feedImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            feedImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
        ])
        
        NSLayoutConstraint.activate([
            scoreLabel.topAnchor.constraint(equalTo: feedImageView.bottomAnchor, constant: 20),
            scoreLabel.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
            scoreLabel.bottomAnchor.constraint(equalTo: additionalSeparator.topAnchor, constant: -16),
            scoreLabel.widthAnchor.constraint(equalToConstant: 126),
            scoreLabel.heightAnchor.constraint(equalToConstant: 26),
        ])
        
        NSLayoutConstraint.activate([
            commentCountLabel.topAnchor.constraint(equalTo: feedImageView.bottomAnchor, constant: 20),
            commentCountLabel.widthAnchor.constraint(equalToConstant: 126),
            commentCountLabel.heightAnchor.constraint(equalToConstant: 26),
            commentCountLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: 5)
        ])
        
        setConstraintsForSeparator()
    }
    
    func setConstraintsForSeparator() {
        self.additionalSeparator.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 0).isActive = true
        self.additionalSeparator.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -self.separatorInset.right).isActive = true
        self.additionalSeparator.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: 0).isActive = true
        self.additionalSeparator.heightAnchor.constraint(equalToConstant: 10).isActive = true
        self.additionalSeparator.backgroundColor = UIColor.lightGray
    }
    
    // Set data for feed
    func configure(data: ChildrenData?) {
        // Show title
        if let children = data?.dataValue?.title {
            feedTitleLabel.text = children
        }
        
        // Show score & comment count
        scoreLabel.text = "Score: \(String(AppUtility.formatPoints(num: data?.dataValue?.score ?? 0)))"
        commentCountLabel.text = "Comments: \(String(AppUtility.formatPoints(num: data?.dataValue?.numOfComments ?? 0)))"
        
        // Show feed image
        guard let imageUrlString = data?.dataValue?.thumbnail,
              let imageWidth = data?.dataValue?.thumbnailWidth,
              let imageHeight = data?.dataValue?.thumbnailHeight, imageUrlString.isImage() else {
            feedImageView.image = UIImage(named: "ic_placeholder")
            feedImageViewHeightConstraint?.constant = CGFloat(AppConstants.feedImageHeight)
            return
        }
        
        feedImageView.imageFromServerURL(imageUrlString, placeHolder: UIImage(named: "ic_placeholder"))
        let height = AppUtility.getFeedImageHeight(image: feedImageView.image ?? UIImage(), imageWidth: CGFloat(imageWidth), imageHeight: CGFloat(imageHeight))
        feedImageViewHeightConstraint?.constant = height
        
    }
}
