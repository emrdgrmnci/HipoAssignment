//
//  MemberDetailViewController.swift
//  HipoAssignment
//
//  Created by Ali Emre Değirmenci on 26.02.2020.
//  Copyright © 2020 Ali Emre Degirmenci. All rights reserved.
//

import UIKit
import Foundation

class MemberDetailViewController: UIViewController {

    var selectedUserData: String = ""
    var selectedDetailUserName: String = ""
    var selectedDetailFollowerCount: Int = 0
    var selectedDetailFollowingCount: Int = 0
    var selectedDetailRepoName: String = ""
    var selectedDetailRepoDate: String = ""
    var selectedDetailLanguage: String = ""
    var selectedDetailRepoStar: String = ""

    weak var delegate: MembersViewController!

    var tableView = UITableView()
    var followersLabel = UILabel()
    var followingLabel = UILabel()

    var profileView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(red:0.14, green:0.16, blue:0.18, alpha: 1.0)
        return view
    }()

    lazy var imageView = UIImageView()

    var github: Github?
    var githubRepo: RepoElement? 

    var safeArea: UILayoutGuide!

    override func viewDidLoad() {
        super.viewDidLoad()
        print(selectedUserData)
        safeArea = view.layoutMarginsGuide

        self.title = selectedDetailUserName
//        self.followersLabel.text = "\(selectedDetailFollowerCount)"


        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "MemberDetailCell")
        setupView()
    }

    func setupView() {
        view.addSubview(profileView)
        view.addSubview(imageView)
        view.addSubview(followersLabel)
        view.addSubview(followingLabel)
        view.addSubview(tableView)

        profileView.topAnchor.constraint(equalTo: safeArea.topAnchor).isActive = true
        profileView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        profileView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        profileView.bottomAnchor.constraint(equalTo: tableView.topAnchor).isActive = true

        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "businessman")
        imageView.layer.borderWidth = 1.0
        imageView.layer.borderColor = UIColor.lightGray.cgColor
        imageView.layer.cornerRadius = 16  /*self.imageView.frame.width/4.0*/
        imageView.clipsToBounds = true
        imageView.heightAnchor.constraint(equalToConstant: 64).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 64).isActive = true
        imageView.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor).isActive = true
        imageView.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 40).isActive = true

        followersLabel.text = "Followers 10"
        followersLabel.font = followersLabel.font.withSize(13)
        followersLabel.textColor = .white
        followersLabel.translatesAutoresizingMaskIntoConstraints = false
        followersLabel.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor, constant: -80).isActive = true
        followersLabel.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 120).isActive = true

        followingLabel.text = "Following 20"
        followingLabel.font = followingLabel.font.withSize(13)
        followingLabel.textColor = .white
        followingLabel.translatesAutoresizingMaskIntoConstraints = false
        followingLabel.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor, constant: 80).isActive = true
        followingLabel.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 120).isActive = true


        //MARK: -  tableView layouts
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 265).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.register(MemberDetailTableViewCell.self, forCellReuseIdentifier: "MemberDetailTableViewCell")
        tableView.rowHeight = 60
    }

    func githubRequest() {

    }


}

extension MemberDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Repositories"
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
let cell = tableView.dequeueReusableCell(withIdentifier: "MemberDetailTableViewCell", for: indexPath) as! MemberDetailTableViewCell
        cell.repoNameLabel.text = selectedDetailRepoName
        cell.dateLabel.text = githubRepo?.updatedAt
//        cell.languageLabel.text = githubRepo!.language
        cell.starLabel.text = "⭐️\(String(describing: githubRepo?.stargazersCount))"
        return cell
    }
}

