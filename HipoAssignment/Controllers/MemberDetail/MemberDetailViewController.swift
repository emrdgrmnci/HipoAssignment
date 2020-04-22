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

    // MARK: - View's Lifecycle
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

    //MARK: - getGithubData
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

    //MARK: - getGithubRepoData
    func getGithubRepoData(){
        GithubRequest.getGithubRepoData(userName: selectedDetailUserName) { (result) in
            self.repos = result
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

    //MARK: - setupView
    func setupView() {
        view.addSubview(profileView)
        view.addSubview(imageView)
        view.addSubview(followersLabel)
        view.addSubview(followingLabel)
        view.addSubview(tableView)

        activateAllConstraints()

        [imageView, followersLabel, followingLabel, tableView].forEach {$0.translatesAutoresizingMaskIntoConstraints = false}
        [followersLabel, followingLabel].forEach {
            $0.textColor = .white
            $0.font = $0.font.withSize(13)
        }

        imageView.image = UIImage(named: "businessman")
        imageView.layer.borderWidth = 1.0
        imageView.layer.borderColor = UIColor.lightGray.cgColor
        imageView.layer.cornerRadius = 16  /*self.imageView.frame.width/4.0*/
        imageView.clipsToBounds = true

        followersLabel.text = "Followers 10"
        followingLabel.text = "Following 20"

        //MARK: -  tableView layouts
        tableView.register(MemberDetailTableViewCell.self, forCellReuseIdentifier: "MemberDetailTableViewCell")
        tableView.rowHeight = 51
    }

    //MARK: - activateAllConstraints
    func activateAllConstraints() {
        NSLayoutConstraint.activate([
            profileView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            profileView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            profileView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            profileView.bottomAnchor.constraint(equalTo: tableView.topAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 64),
            imageView.widthAnchor.constraint(equalToConstant: 64),
            imageView.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
            imageView.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 40),
            followersLabel.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor, constant: -80),
            followersLabel.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 120),
            followingLabel.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor, constant: 80),
            followingLabel.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 120),
            tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 235),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }

    //MARK: - formattedDate
    public func formattedDate(of publishedAt: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy'-'MM'-'dd'T'HH':'mm':'ss'Z'"
        let publishedDate = formatter.date(from: publishedAt)
        formatter.dateFormat = "dd-MMMM-yyyy"
        let formattedDate = formatter.string(from: publishedDate!)
        return formattedDate
    }
}

//MARK: - UITableViewDataSource
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
        cell.dateLabel.text = "\(String(describing: formattedDate(of: repos[indexPath.row].updated_at ?? "")))"
        cell.starLabel.text = "⭐️\(repos[indexPath.row].stargazers_count ?? 0)"
        return cell
    }
}

