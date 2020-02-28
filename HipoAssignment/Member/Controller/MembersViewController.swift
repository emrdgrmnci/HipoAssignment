//
//  ViewController.swift
//  HipoAssignment
//
//  Created by Ali Emre Değirmenci on 26.02.2020.
//  Copyright © 2020 Ali Emre Degirmenci. All rights reserved.
//

import UIKit
import Foundation

class MembersViewController: UIViewController {
    //UI Components
    var tableView = UITableView()
    @objc lazy var sortMembersButton = UIButton()
    @objc lazy var addNewMemberButton = UIButton()
    var buttonStackView = UIStackView()

    var hipoMembers: Hipo? = nil
    var githubInfo = [Github]()
    var repoElement:Repo? = nil

    var safeArea: UILayoutGuide!

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        self.title = "Members"

        getJSONData()

        safeArea = view.layoutMarginsGuide

        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "MembersCell")

        addNewMemberButton.addTarget(self, action:#selector(self.addNewMemberButtonClicked), for: .touchUpInside)
        sortMembersButton.addTarget(self, action:#selector(self.sortMembersButtonClicked), for: .touchUpInside)

        setupView()
    }

    //MARK: - Setup View
    func setupView() {
        view.addSubview(tableView)
        view.addSubview(sortMembersButton)
        view.addSubview(addNewMemberButton)

        //MARK: - sort members button layouts
        sortMembersButton.setTitle("SORT MEMBERS", for: .normal)
        sortMembersButton.backgroundColor = UIColor(red:0.17, green:0.19, blue:0.22, alpha:1.0)
        sortMembersButton.translatesAutoresizingMaskIntoConstraints = false
        sortMembersButton.topAnchor.constraint(equalTo: tableView.bottomAnchor, constant: 50).isActive = true
        sortMembersButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50).isActive = true
        sortMembersButton.bottomAnchor.constraint(equalTo: addNewMemberButton.topAnchor, constant: -20).isActive = true
        sortMembersButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50).isActive = true
        sortMembersButton.widthAnchor.constraint(equalToConstant: 285).isActive = true
        sortMembersButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        sortMembersButton.layer.cornerRadius = 25

        //MARK: - add new member button layouts
        addNewMemberButton.setTitle("ADD NEW MEMBER", for: .normal)
        addNewMemberButton.backgroundColor = UIColor(red:0.18, green:0.73, blue:0.31, alpha:1.0)
        addNewMemberButton.translatesAutoresizingMaskIntoConstraints = false
        addNewMemberButton.topAnchor.constraint(equalTo: sortMembersButton.bottomAnchor, constant: -20).isActive = true
        addNewMemberButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50).isActive = true
        addNewMemberButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -80).isActive = true
        addNewMemberButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50).isActive = true
        addNewMemberButton.widthAnchor.constraint(equalToConstant: 285).isActive = true
        addNewMemberButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        addNewMemberButton.layer.cornerRadius = 25

        //MARK: -  tableView layouts
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: safeArea.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -250).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }

    //MARK: - Get JSONData
    func getJSONData() {
        do {
            let data = try Data(contentsOf: Bundle.main.url(forResource: "hipo", withExtension: "json")!)
            hipoMembers = try JSONDecoder().decode(Hipo.self, from: data)
            tableView.reloadData()
        } catch { print(error) }
    }

    //MARK: - Sort Members Button Click
    @objc func sortMembersButtonClicked(_ sender: UIButton?) {
        print("Sort Button Clicked")
        hipoMembers?.members.forEach {
            print("\($0.name.countInstances(of: "a"))")
    }
    }

    //MARK: - Add New Member Button Click
    @objc func addNewMemberButtonClicked(_ sender: UIButton?) {
        print("Add New Member Button Clicked")
        let addNewMemberVC = AddNewMemberViewController()
        self.navigationController?.pushViewController(addNewMemberVC, animated: true)
    }

    func sortingMembers(with text: [String], char: Character) -> [String] {
        return ["Kotlin", "Swift"]
    }
}

//MARK: - UITableViewDataSource

extension MembersViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (hipoMembers?.members.count)!
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MembersCell", for: indexPath)
        cell.textLabel?.text = hipoMembers?.members[indexPath.row].name
        cell.detailTextLabel?.text = hipoMembers?.members[indexPath.row].github
        cell.accessoryType = .disclosureIndicator
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        tableView.reloadData()

        let githubUsername = hipoMembers!.members[indexPath.row].github //github username
        let githubRequest = GithubRequest(userName: githubUsername)
        githubRequest.getGithubData()
        githubRequest.getGithubRepoData()

        let memberDetailController = MemberDetailViewController()
        self.navigationController?.pushViewController(memberDetailController, animated: true)
        memberDetailController.delegate = self
        //        getGithubData(with: hipoMembers!.members[indexPath.row].github)//username added end of the url path from github
        //        getGithubRepoData(with: hipoMembers!.members[indexPath.row].github)

        memberDetailController.selectedDetailUserName = self.hipoMembers!.members[indexPath.row].name
        //        memberDetailController.selectedDetailFollowerCount = self.githubInfo[indexPath.row].followers
        //        memberDetailController.selectedDetailFollowingCount = self.githubInfo[indexPath.row].following
//                memberDetailController.selectedDetailLanguage = self.repoElement![indexPath.row].language

        //        memberDetailController.selectedDetailLanguage = repoElement!.language
        
        //        memberDetailController.selectedDetailLanguage = repoElement!.language

        memberDetailController.selectedDetailUserName = hipoMembers!.members[indexPath.row].github
    }
}

