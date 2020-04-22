//
//  ViewController.swift
//  HipoAssignment
//
//  Created by Ali Emre Değirmenci on 26.02.2020.
//  Copyright © 2020 Ali Emre Degirmenci. All rights reserved.
//

import UIKit
import Foundation
import CoreData

class MembersViewController: UIViewController {

    //UI Components
    private var tableView = UITableView()
    @objc lazy var sortMembersButton = UIButton()
    @objc lazy var addNewMemberButton = UIButton()
    private var buttonStackView = UIStackView()

    private var memberArray = [Member]()
    private var hipoMembers: [Member] = []
    private var githubInfo = [Github]()
    private var repos = [Repo]()

    private var safeArea: UILayoutGuide!

    // MARK: - View's Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        self.title = NSLocalizedString("Members", comment: "")

        getNewMemberDataToMembersTableView()

        safeArea = view.layoutMarginsGuide

        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "MembersCell")

        addNewMemberButton.addTarget(self, action:#selector(self.addNewMemberButtonClicked), for: .touchUpInside)
        sortMembersButton.addTarget(self, action:#selector(self.sortMembersButtonClicked), for: .touchUpInside)

        setupView()
    }

    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(getNewMemberDataToMembersTableView), name: NSNotification.Name(rawValue: "newData"), object: nil)
    }

    //MARK: - Get Core Data
    @objc func getNewMemberDataToMembersTableView() {

        hipoMembers.removeAll(keepingCapacity: false)
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "HipoMember")
        fetchRequest.returnsObjectsAsFaults = false
        do {
            let results = try context.fetch(fetchRequest)
            if results.count > 0 {
                for result in results as! [NSManagedObject] {
                    var member = Member(name: "", age: 0, location: "", github: "", hipo: HipoClass(position: "", yearsInHipo: 0))
                    if let name = result.value(forKey: "name") as? String {
                        member.name = name
                    }
                    if let age = result.value(forKey: "age") as? Int {
                        member.age = age
                    }
                    if let location = result.value(forKey: "location") as? String {
                        member.location = location
                    }
                    if let github = result.value(forKey: "github") as? String {
                        member.github = github
                    }
                    if let position = result.value(forKey: "position") as? String {
                        member.hipo.position = position
                    }
                    if let yearsInHipo = result.value(forKey: "years_in_hipo") as? Int {
                        member.hipo.yearsInHipo = yearsInHipo
                    }
                    if member.name != "" {
                        hipoMembers.append(member)
                    }
                }
            }
            self.tableView.reloadData()
        } catch {
            print("error")
        }
    }

    //MARK: - Setup View
    func setupView() {
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
        view.addSubview(sortMembersButton)
        view.addSubview(addNewMemberButton)

        buttonConstraints()
        activateAllConstraints()

        //MARK: - sort members button layouts
        sortMembersButton.setTitle(NSLocalizedString("SORT MEMBERS", comment: ""), for: .normal)
        sortMembersButton.backgroundColor = UIColor(red:0.17, green:0.19, blue:0.22, alpha:1.0)
        sortMembersButton.layer.cornerRadius = 25

        //MARK: - add new member button layouts
        addNewMemberButton.setTitle(NSLocalizedString("ADD NEW MEMBER", comment: ""), for: .normal)
        addNewMemberButton.backgroundColor = UIColor(red:0.18, green:0.73, blue:0.31, alpha:1.0)
        addNewMemberButton.layer.cornerRadius = 25

        //MARK: -  tableView layouts
        tableView.translatesAutoresizingMaskIntoConstraints = false

    }

    //MARK: - activateAllConstraints
    func activateAllConstraints() {
        NSLayoutConstraint.activate([
            sortMembersButton.topAnchor.constraint(equalTo: tableView.bottomAnchor, constant: 50),
            sortMembersButton.bottomAnchor.constraint(equalTo: addNewMemberButton.topAnchor, constant: -20),
            addNewMemberButton.topAnchor.constraint(equalTo: sortMembersButton.bottomAnchor, constant: -20),
            addNewMemberButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -80),

            tableView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -250),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }

    //MARK: - buttonConstraints
    func buttonConstraints() {
        [sortMembersButton, addNewMemberButton] .forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false

            NSLayoutConstraint.activate([
                $0.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
                $0.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
                $0.widthAnchor.constraint(equalToConstant: 285),
                $0.heightAnchor.constraint(equalToConstant: 50)
            ])
        }
    }


    //MARK: - Sort Members Button Click
    // I am only counted characters of members who has "a" letters in their name
    @objc func sortMembersButtonClicked(_ sender: UIButton?) {
        print("Sort Button Clicked")
        hipoMembers.forEach {
            sortingMembers(with: [$0.name.lowercased()], char: "a")
            print("\($0.name.countInstances(of: "a"))")
            print("\($0.name)")
        }
    }

    //MARK: - Add New Member Button Click
    @objc func addNewMemberButtonClicked(_ sender: UIButton?) {
        print("Add New Member Button Clicked")
        let addNewMemberVC = AddNewMemberViewController()
        self.navigationController?.pushViewController(addNewMemberVC, animated: true)
    }

    func sortingMembers(with text: [String], char: Character) -> [String] {
        return ["Swift", "Kotlin"]
    }
}

//MARK: - UITableViewDataSource
extension MembersViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return hipoMembers.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MembersCell", for: indexPath)
        cell.textLabel?.text = hipoMembers[indexPath.row].name
        cell.accessoryType = .disclosureIndicator
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard hipoMembers.count != 0 else {return}
        let memberDetailController = MemberDetailViewController()
        self.navigationController?.pushViewController(memberDetailController, animated: true)
        memberDetailController.delegate = self
        memberDetailController.title = hipoMembers[indexPath.row].name
        memberDetailController.selectedDetailUserName = hipoMembers[indexPath.row].github
    }
}


