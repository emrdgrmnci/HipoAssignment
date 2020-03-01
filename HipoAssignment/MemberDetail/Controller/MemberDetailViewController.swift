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

    var repos = [Repo]()
    var github: Github?

    var selectedDetailUserName: String = ""

    weak var delegate: MembersViewController!

    var tableView = UITableView()
    var followersLabel = UILabel()
    var followingLabel = UILabel()
    var imageView = UIImageView()
    var indicator = UIActivityIndicatorView()

    var profileView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(red:0.14, green:0.16, blue:0.18, alpha: 1.0)
        return view
    }()

    var safeArea: UILayoutGuide!

    override func viewDidLoad() {
        super.viewDidLoad()

        safeArea = view.layoutMarginsGuide

        tableView.dataSource = self
        tableView.register(MemberDetailTableViewCell.self, forCellReuseIdentifier: "MemberDetailCell")
        setupView()

    }

    override func viewWillAppear(_ animated: Bool) {
        getGithubData()
        getGithubRepoData()
    }

    func getGithubData(){
        GithubRequest.getGithubData(userName: selectedDetailUserName) { (result) in
            guard let avatarUrl = result.avatar_url, let url = URL(string: avatarUrl), let data = try? Data(contentsOf: url) else { return }
            DispatchQueue.main.async {
                self.imageView.image=UIImage(data: data as Data)
                self.followersLabel.text = "Followers \(result.followers ?? 0)"
                self.followingLabel.text = "Following \(result.following ?? 0)"
            }
        }
    }

    func getGithubRepoData(){
        GithubRequest.getGithubRepoData(userName: selectedDetailUserName) { (result) in
            self.repos = result
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
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
        tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 235).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.register(MemberDetailTableViewCell.self, forCellReuseIdentifier: "MemberDetailTableViewCell")
        tableView.rowHeight = 51
    }
}

extension MemberDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Repositories"
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repos.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MemberDetailCell", for: indexPath) as! MemberDetailTableViewCell

        cell.languageLabel.text = repos[indexPath.row].language
        cell.repoNameLabel.text = repos[indexPath.row].name
        cell.dateLabel.text = repos[indexPath.row].updated_at
        cell.starLabel.text = "⭐️\(repos[indexPath.row].stargazers_count ?? 0)"
        return cell
    }
}

