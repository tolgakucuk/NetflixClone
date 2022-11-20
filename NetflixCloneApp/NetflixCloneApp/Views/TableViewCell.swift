//
//  UpcomingTableViewCell.swift
//  NetflixCloneApp
//
//  Created by Tolga on 7.11.2022.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    static let identifier = "TableViewCell"
    
    private let upcomingPosterView: UIImageView = {
        let imageView =  UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let upcomingTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let upcomingPlayTitleButton: UIButton = {
        let button = UIButton()
        let image = UIImage(systemName: "play.circle", withConfiguration: UIImage.SymbolConfiguration(pointSize: 25))
        button.setImage(image, for: .normal)
        button.tintColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(upcomingPosterView)
        contentView.addSubview(upcomingTitleLabel)
        contentView.addSubview(upcomingPlayTitleButton)
        
        applyConstraints()
    }
    
    private func applyConstraints() {
        let upcomingPosterViewConstraints = [
            upcomingPosterView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            upcomingPosterView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            upcomingPosterView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            upcomingPosterView.widthAnchor.constraint(equalToConstant: 100)
        ]
        
        let upcomingTitleLabelConstraints = [
            upcomingTitleLabel.leadingAnchor.constraint(equalTo: upcomingPosterView.trailingAnchor, constant: 20),
            upcomingTitleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ]
        
        let upcomingPlayTitleButtonConstraints = [
            upcomingPlayTitleButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            upcomingPlayTitleButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)

        ]
        
        NSLayoutConstraint.activate(upcomingPosterViewConstraints)
        NSLayoutConstraint.activate(upcomingTitleLabelConstraints)
        NSLayoutConstraint.activate(upcomingPlayTitleButtonConstraints)
    }
    
    public func configure(width model: TitleViewModel) {
        guard let url = URL(string: "https://image.tmdb.org/t/p/w500/\(model.posterURL)") else {return}
        upcomingPosterView.sd_setImage(with: url, completed: nil)
        upcomingTitleLabel.text = model.titleName
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
