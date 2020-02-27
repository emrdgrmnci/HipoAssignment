//
//  MemberDetailTableViewCell.swift
//  HipoAssignment
//
//  Created by Ali Emre Değirmenci on 27.02.2020.
//  Copyright © 2020 Ali Emre Degirmenci. All rights reserved.
//

import UIKit

class MemberDetailTableViewCell: UITableViewCell {

     var repoNameLabel = UILabel()
     var languageLabel = UILabel()
     var dateLabel = UILabel()
     var starLabel = UILabel()

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
//        repoNameLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        repoNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true

        languageLabel.translatesAutoresizingMaskIntoConstraints = false
//        languageLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        languageLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        languageLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12).isActive = true

        dateLabel.translatesAutoresizingMaskIntoConstraints = false
//        dateLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        dateLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true

        starLabel.translatesAutoresizingMaskIntoConstraints = false
//        starLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        starLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
        starLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12).isActive = true
    }
}
