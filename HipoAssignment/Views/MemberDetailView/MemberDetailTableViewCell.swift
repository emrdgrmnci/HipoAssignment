//
//  MemberDetailTableViewCell.swift
//  HipoAssignment
//
//  Created by Ali Emre Değirmenci on 27.02.2020.
//  Copyright © 2020 Ali Emre Degirmenci. All rights reserved.
//

import UIKit

class MemberDetailTableViewCell: UITableViewCell {

    private(set) var repoNameLabel = UILabel()
    private(set) var languageLabel = UILabel()
    private(set) var dateLabel = UILabel()
    private(set) var starLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(repoNameLabel)
        addSubview(languageLabel)
        addSubview(dateLabel)
        addSubview(starLabel)

        setupView()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupView() {
        repoNameLabel.translatesAutoresizingMaskIntoConstraints = false
        repoNameLabel.font = repoNameLabel.font.withSize(14)
        repoNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30).isActive = true

        languageLabel.translatesAutoresizingMaskIntoConstraints = false
        languageLabel.textColor = UIColor(red:0.18, green:0.73, blue:0.31, alpha:1.0)
        languageLabel.font = languageLabel.font.withSize(12)
        languageLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30).isActive = true
        languageLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12).isActive = true

        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.font = dateLabel.font.withSize(14)
        dateLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30).isActive = true

        starLabel.translatesAutoresizingMaskIntoConstraints = false
        starLabel.font = starLabel.font.withSize(12)
        starLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30).isActive = true
        starLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12).isActive = true
    }
}
