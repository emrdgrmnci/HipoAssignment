//
//  AddNewMemberViewController.swift
//  HipoAssignment
//
//  Created by Ali Emre Değirmenci on 26.02.2020.
//  Copyright © 2020 Ali Emre Degirmenci. All rights reserved.
//

import UIKit

class AddNewMemberViewController: UIViewController {

    var nameArray = [String]()
    var positionArray = [String]()
    var ageArray = [Int]()
    var locationArray = [String]()
    var yearsInHipoArray = [Int]()
    var githubArray = [String]()

    //UI Components
    lazy var nameLabel = UILabel()
    lazy var positionLabel = UILabel()
    lazy var ageLabel = UILabel()
    lazy var locationLabel = UILabel()
    lazy var yearsInHipoLabel = UILabel()
    lazy var githubLabel = UILabel()
    lazy var saveButton = UIButton()
    lazy var scrollView: UIScrollView = {
        let view = UIScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentSize.height = 900
        view.backgroundColor = .white

        return view
    }()

    lazy var nameTextField = UITextField()
    lazy var positionTextField = UITextField()
    lazy var ageTextField = UITextField()
    lazy var locationTextField = UITextField()
    lazy var yearsInHipoTextField = UITextField()
    lazy var githubTextField = UITextField()

    /*
     UILabel(frame: CGRect(x: 20, y: 80, width: 100, height: 20))
     UILabel(frame: CGRect(x: 20, y: 180, width: 100, height: 20))
     UILabel(frame: CGRect(x: 20, y: 280, width: 100, height: 20))
     UILabel(frame: CGRect(x: 20, y: 380, width: 100, height: 20))
     UILabel(frame: CGRect(x: 20, y: 480, width: 100, height: 20))
     UILabel(frame: CGRect(x: 20, y: 580, width: 100, height: 20))
     UITextField(frame: CGRect(x: 20, y: 100, width: 345, height: 50))
     UITextField(frame: CGRect(x: 20, y: 200, width: 345, height: 50))
     UITextField(frame: CGRect(x: 20, y: 300, width: 345, height: 50))
     UITextField(frame: CGRect(x: 20, y: 400, width: 345, height: 50))
     UITextField(frame: CGRect(x: 20, y: 500, width: 345, height: 50))
     UITextField(frame: CGRect(x: 20, y: 600, width: 345, height: 50))
     */


    var safeArea: UILayoutGuide!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Add New Member"
        //        nameTextField.delegate = self
        setupView()

        if let name = UserDefaults.standard.value(forKey: "NameArray") as? [String] {
            nameArray = name
        }
        if let position = UserDefaults.standard.value(forKey: "PositionArray") as? [String] {
            nameArray = position
        }
        if let age = UserDefaults.standard.value(forKey: "AgeArray") as? [Int] {
            ageArray = age
        }
        if let location = UserDefaults.standard.value(forKey: "LocationArray") as? [String] {
            locationArray = location
        }
        if let years = UserDefaults.standard.value(forKey: "YearsArray") as? [Int] {
            yearsInHipoArray = years
        }
        if let github = UserDefaults.standard.value(forKey: "GithubArray") as? [String] {
            githubArray = github
        }
    }

    func setupView() {

        view.addSubview(scrollView)
        view.addSubview(nameLabel)
        view.addSubview(nameTextField)
        view.addSubview(positionLabel)
        view.addSubview(positionTextField)
        view.addSubview(ageLabel)
        view.addSubview(ageTextField)
        view.addSubview(locationLabel)
        view.addSubview(locationTextField)
        view.addSubview(yearsInHipoLabel)
        view.addSubview(yearsInHipoTextField)
        view.addSubview(githubLabel)
        view.addSubview(githubTextField)
        view.addSubview(saveButton)

        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true

        scrollView.addSubview(nameLabel)
        nameLabel.text = "Name:"
        nameLabel.font = nameLabel.font.withSize(13)
        nameLabel.textColor = .black
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        nameLabel.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 20).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 30).isActive = true

        scrollView.addSubview(nameTextField)
        nameTextField.placeholder = "Please enter your name"
        nameTextField.font = UIFont.systemFont(ofSize: 15)
        nameTextField.borderStyle = UITextField.BorderStyle.roundedRect
        nameTextField.autocorrectionType = UITextAutocorrectionType.no
        nameTextField.keyboardType = UIKeyboardType.default
        nameTextField.returnKeyType = UIReturnKeyType.done
        nameTextField.clearButtonMode = UITextField.ViewMode.whileEditing
        nameTextField.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        nameTextField.translatesAutoresizingMaskIntoConstraints = false
        nameTextField.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        nameTextField.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 40).isActive = true
        nameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25).isActive = true
        nameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15).isActive = true

        scrollView.addSubview(positionLabel)
        positionLabel.text = "Position:"
        positionLabel.font = positionLabel.font.withSize(13)
        positionLabel.textColor = .black
        positionLabel.translatesAutoresizingMaskIntoConstraints = false
        positionLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        positionLabel.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 100).isActive = true
        positionLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 30).isActive = true

        scrollView.addSubview(positionTextField)
        positionTextField.placeholder = "Please enter your position"
        positionTextField.font = UIFont.systemFont(ofSize: 15)
        positionTextField.borderStyle = UITextField.BorderStyle.roundedRect
        positionTextField.autocorrectionType = UITextAutocorrectionType.no
        positionTextField.keyboardType = UIKeyboardType.default
        positionTextField.returnKeyType = UIReturnKeyType.done
        positionTextField.clearButtonMode = UITextField.ViewMode.whileEditing
        positionTextField.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        positionTextField.translatesAutoresizingMaskIntoConstraints = false
        positionTextField.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        positionTextField.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 120).isActive = true
        positionTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25).isActive = true
        positionTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15).isActive = true

        scrollView.addSubview(ageLabel)
        ageLabel.text = "Age:"
        ageLabel.font = ageLabel.font.withSize(13)
        ageLabel.textColor = .black
        ageLabel.translatesAutoresizingMaskIntoConstraints = false
        ageLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        ageLabel.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 180).isActive = true
        ageLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 30).isActive = true

        scrollView.addSubview(ageTextField)
        ageTextField.placeholder = "Please enter your age"
        ageTextField.font = UIFont.systemFont(ofSize: 15)
        ageTextField.borderStyle = UITextField.BorderStyle.roundedRect
        ageTextField.autocorrectionType = UITextAutocorrectionType.no
        ageTextField.keyboardType = UIKeyboardType.default
        ageTextField.returnKeyType = UIReturnKeyType.done
        ageTextField.clearButtonMode = UITextField.ViewMode.whileEditing
        ageTextField.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        ageTextField.translatesAutoresizingMaskIntoConstraints = false
        ageTextField.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        ageTextField.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 200).isActive = true
        ageTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25).isActive = true
        ageTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15).isActive = true

        scrollView.addSubview(locationLabel)
        locationLabel.text = "Location:"
        locationLabel.font = locationLabel.font.withSize(13)
        locationLabel.textColor = .black
        locationLabel.translatesAutoresizingMaskIntoConstraints = false
        locationLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        locationLabel.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 260).isActive = true
        locationLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 30).isActive = true

        scrollView.addSubview(locationTextField)
        locationTextField.placeholder = "Please enter your location"
        locationTextField.font = UIFont.systemFont(ofSize: 15)
        locationTextField.borderStyle = UITextField.BorderStyle.roundedRect
        locationTextField.autocorrectionType = UITextAutocorrectionType.no
        locationTextField.keyboardType = UIKeyboardType.default
        locationTextField.returnKeyType = UIReturnKeyType.done
        locationTextField.clearButtonMode = UITextField.ViewMode.whileEditing
        locationTextField.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        locationTextField.translatesAutoresizingMaskIntoConstraints = false
        locationTextField.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        locationTextField.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 280).isActive = true
        locationTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25).isActive = true
        locationTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15).isActive = true

        scrollView.addSubview(yearsInHipoLabel)
        yearsInHipoLabel.text = "Number of years in Hipo:"
        yearsInHipoLabel.font = yearsInHipoLabel.font.withSize(13)
        yearsInHipoLabel.textColor = .black
        yearsInHipoLabel.translatesAutoresizingMaskIntoConstraints = false
        yearsInHipoLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        yearsInHipoLabel.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 340).isActive = true
        yearsInHipoLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 30).isActive = true

        scrollView.addSubview(yearsInHipoTextField)
        yearsInHipoTextField.placeholder = "Please enter how many years you worked in Hipo"
        yearsInHipoTextField.font = UIFont.systemFont(ofSize: 15)
        yearsInHipoTextField.borderStyle = UITextField.BorderStyle.roundedRect
        yearsInHipoTextField.autocorrectionType = UITextAutocorrectionType.no
        yearsInHipoTextField.keyboardType = UIKeyboardType.default
        yearsInHipoTextField.returnKeyType = UIReturnKeyType.done
        yearsInHipoTextField.clearButtonMode = UITextField.ViewMode.whileEditing
        yearsInHipoTextField.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        yearsInHipoTextField.translatesAutoresizingMaskIntoConstraints = false
        yearsInHipoTextField.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        yearsInHipoTextField.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 360).isActive = true
        yearsInHipoTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25).isActive = true
        yearsInHipoTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15).isActive = true

        scrollView.addSubview(githubLabel)
        githubLabel.text = "Github:"
        githubLabel.font = githubLabel.font.withSize(13)
        githubLabel.textColor = .black
        githubLabel.translatesAutoresizingMaskIntoConstraints = false
        githubLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        githubLabel.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 420).isActive = true
        githubLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 30).isActive = true

        scrollView.addSubview(githubTextField)
        githubTextField.placeholder = "Please enter your Github username"
        githubTextField.font = UIFont.systemFont(ofSize: 15)
        githubTextField.borderStyle = UITextField.BorderStyle.roundedRect
        githubTextField.autocorrectionType = UITextAutocorrectionType.no
        githubTextField.keyboardType = UIKeyboardType.default
        githubTextField.returnKeyType = UIReturnKeyType.done
        githubTextField.clearButtonMode = UITextField.ViewMode.whileEditing
        githubTextField.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        githubTextField.translatesAutoresizingMaskIntoConstraints = false
        githubTextField.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        githubTextField.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 440).isActive = true
        githubTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25).isActive = true
        githubTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15).isActive = true

        scrollView.addSubview(saveButton)
        //MARK: - add new member button layouts
        saveButton.setTitle("SAVE", for: .normal)
        saveButton.backgroundColor = UIColor(red:0.18, green:0.73, blue:0.31, alpha:1.0)
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        saveButton.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        //        saveButton.topAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -20).isActive = true
        saveButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50).isActive = true
        saveButton.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: 560).isActive = true
        saveButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50).isActive = true
        saveButton.widthAnchor.constraint(equalToConstant: 285).isActive = true
        saveButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        saveButton.layer.cornerRadius = 25
    }

    //name: nameTextField.text!, age: ageTextField.text!, location: locationTextField.text!, github: githubTextField.text!, hipo: HipoClass(position: positionTextField.text!, yearsInHipo: yearsInHipoTextField.text!
    func convertoJSON() {
        let foo = Member(name: "Emre", age: 25, location: "Izmir", github: "emrdgrmnci", hipo: HipoClass(position: "iOS", yearsInHipo: 0))
        do {
            let data = try JSONSerialization.data(withJSONObject: foo, options: [])
            if let dataString = String(data: data, encoding: .utf8) {
                print(dataString)
            }
        } catch {
            print(error)
        }
        //        let foo = Member(name: "Emre", age: 25, location: "Izmir", github: "emrdgrmnci", hipo: HipoClass(position: "iOS", yearsInHipo: 0))
        //        do {
        //            let fileURL = try FileManager.default
        //                .url(for: .applicationSupportDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
        //                .appendingPathComponent("hipo.json")
        //
        //            try JSONEncoder().encode(foo)
        //                .write(to: fileURL)
        //        } catch {
        //            print(error)
        //        }
    }

    func writeToJSON() {
        let foo = Member(name: "Emre", age: 25, location: "Izmir", github: "emrdgrmnci", hipo: HipoClass(position: "iOS", yearsInHipo: 0))
        do {
            let data = try JSONSerialization.data(withJSONObject: foo, options: [])
            if let documentDirectoryUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
                let fileUrl = documentDirectoryUrl.appendingPathComponent("hipo.json")
                try data.write(to: fileUrl)
            }
        } catch {
            print(error)
        }
    }

    /*
     // MARK: - Navigation

     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */

}
