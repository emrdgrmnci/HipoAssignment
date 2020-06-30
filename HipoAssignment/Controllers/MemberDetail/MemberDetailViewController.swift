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

    private var repos = [Repo]()
    private var github: Github?

    var selectedDetailUserName: String = ""

    weak var delegate: MembersViewController!

    private var tableView = UITableView()
    private var followersLabel = UILabel()
    private var followingLabel = UILabel()
    private var imageView = UIImageView()
    private var indicator = UIActivityIndicatorView()

    private var profileView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(red:0.14, green:0.16, blue:0.18, alpha: 1.0)
        return view
    }()

    private var safeArea: UILayoutGuide!

    // MARK: - View's Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        safeArea = view.layoutMarginsGuide

        tableView.dataSource = self
        tableView.register(MemberDetailTableViewCell.self, forCellReuseIdentifier: "MemberDetailCell")
        setupView()
        getGithubData()
        getGithubRepoData()
    }

    func getGithubData() {
        GithubRequest.githubAPICall(url: URLString.urlForGithub.rawValue + selectedDetailUserName, expectingReturnType: Github.self, completion: { [weak self] result in
            switch result {
            case .success(let github):
                DispatchQueue.main.async {
                    guard let self = self else { return }
                    //                    self.imageView.image = UIImage(data: data as Data)
                    self.followersLabel.text = NSLocalizedString("Followers \(github.followers.self ?? 0)", comment: "")
                    self.followingLabel.text = NSLocalizedString("Following \(github.following.self ?? 0)", comment: "")
                }
            case .failure(let error):
                print(error)
            }
        })
    }
    
    func getGithubRepoData(){
        GithubRequest.githubAPICall(url: URLString.urlForGithub.rawValue + selectedDetailUserName + "/repos", expectingReturnType: [Repo].self, completion: { [weak self] result in
            switch result {
            case .success(let repo):
                DispatchQueue.main.async {
                    guard let self = self else { return }
                    self.repos = repo.self
                    self.tableView.reloadData()
                }
            case .failure(_):
                break
            }

        })
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

        followersLabel.text = NSLocalizedString("Followers 10", comment: "")
        followingLabel.text = NSLocalizedString("Following 20", comment: "")

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
        return NSLocalizedString("Repositories", comment: "")
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repos.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MemberDetailCell", for: indexPath) as! MemberDetailTableViewCell

        cell.languageLabel.text = repos[indexPath.row].language
        cell.repoNameLabel.text = repos[indexPath.row].name
        cell.dateLabel.text = "\(String(describing: formattedDate(of: repos[indexPath.row].updatedAt ?? "")))"
        cell.starLabel.text = "⭐️\(repos[indexPath.row].stargazersCount ?? 0)"
        return cell
    }
}

