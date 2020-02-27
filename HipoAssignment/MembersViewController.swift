//
//  ViewController.swift
//  HipoAssignment
//
//  Created by Ali Emre Değirmenci on 26.02.2020.
//  Copyright © 2020 Ali Emre Degirmenci. All rights reserved.
//

import UIKit

class MembersViewController: UIViewController {
    //UI Components
    lazy var tableView = UITableView()
    @objc lazy var sortMembersButton = UIButton()
    @objc lazy var addNewMemberButton = UIButton()
    lazy var buttonStackView = UIStackView()

    var hipoMembers: Hipo? = nil

    var safeArea: UILayoutGuide!

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        self.title = "Members"
        safeArea = view.layoutMarginsGuide
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "MembersCell")

        addNewMemberButton.addTarget(self, action:#selector(self.addNewMemberButtonClicked), for: .touchUpInside)
        sortMembersButton.addTarget(self, action:#selector(self.sortMembersButtonClicked), for: .touchUpInside)

        setupView()
        getJSONData()

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

    }
    //MARK: - Add New Member Button Click
    @objc func addNewMemberButtonClicked(_ sender: UIButton?) {
        print("Add New Member Button Clicked")
        let addNewMemberVC = AddNewMemberViewController()
        self.navigationController?.pushViewController(addNewMemberVC, animated: true)
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
        cell.accessoryType = .disclosureIndicator
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let members = hipoMembers!.members[indexPath.row]
        let detailController = AddNewMemberViewController()
        //        detailController.memeImage = meme.memedImage //Pass image like this
        //         self.navigationController?.pushViewController(detailController, animated: true)
        //        self.tableView.deselectRow(at: indexPath, animated: true)
        present(detailController,animated: true,completion: nil)
    }
}

