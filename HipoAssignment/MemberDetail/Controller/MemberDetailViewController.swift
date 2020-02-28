//
//  MemberDetailViewController.swift
//  HipoAssignment
//
//  Created by Ali Emre Değirmenci on 26.02.2020.
//  Copyright © 2020 Ali Emre Degirmenci. All rights reserved.
//

import UIKit
import Foundation

//   let repo = try? newJSONDecoder().decode(Repo.self, from: jsonData)

// MARK: - RepoElement
struct RepoElement: Codable {
    let name: String?
    let updatedAt: Date?
    let stargazersCount: Int?
    let language: String?

    enum CodingKeys: String, CodingKey {
        case name
        case updatedAt = "updated_at"
        case stargazersCount = "stargazers_count"
        case language
    }
}

typealias Repo = [RepoElement]

class MemberDetailViewController: UIViewController {
final let url = URL(string: "https://api.github.com/users/emrdgrmnci/repos")

    private var repos: Repo?

    var selectedUserData: String = ""
    var selectedDetailUserName: String = ""
    var selectedDetailFollowerCount: Int?
    var selectedDetailFollowingCount: Int?
    var selectedDetailRepoName: String = ""
    var selectedDetailRepoDate: String = ""
    var selectedDetailLanguage: String = ""
    var selectedDetailRepoStar: String = ""

    weak var delegate: MembersViewController!

    var tableView = UITableView()
    var followersLabel = UILabel()
    var followingLabel = UILabel()
    var imageView = UIImageView()

    var profileView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(red:0.14, green:0.16, blue:0.18, alpha: 1.0)
        return view
    }()

    var github = [Github]()
//    var githubRepo: Repo?

    var safeArea: UILayoutGuide!

    override func viewDidLoad() {
        super.viewDidLoad()
        getGithubData()
        print(selectedUserData)
        safeArea = view.layoutMarginsGuide

        self.title = selectedDetailUserName


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
    //MARK: - Get apiData
    func getGithubData() {
        guard let downloadURL = url else { return }
        URLSession.shared.dataTask(with: downloadURL) { data, urlResponse, error in
            guard let data = data, error == nil, urlResponse != nil else {
                print("something is wrong")
                return
            }
            print("downloaded")
            do
            {
                let decoder = JSONDecoder()
                let downloadedRepos = try decoder.decode(Repo.self, from: data)
                self.repos = downloadedRepos
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            } catch {
                print("something wrong after downloaded")
            }
        }.resume()
        }
    }

//    func getRepoData() {
//        GithubRequest.shared.getRepoData { (response) in
////            self.githubRepo = response
//        }
//    }


extension MemberDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Repositories"
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repos!.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MemberDetailCell", for: indexPath) as! MemberDetailTableViewCell
        cell.languageLabel.text = repos![indexPath.row].language
        return cell
    }
}

/*
if let imageURL = URL(string: actors[indexPath.row].image) {
          DispatchQueue.global().async {
              let data = try? Data(contentsOf: imageURL)
              if let data = data {
                  let image = UIImage(data: data)
                  DispatchQueue.main.async {
                      cell.imgView.image = image
                  }
              }
          }
      }
*/

