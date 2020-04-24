//
//  NewMemberViewController.swift
//  HipoAssignment
//
//  Created by Ali Emre Değirmenci on 23.04.2020.
//  Copyright © 2020 Ali Emre Degirmenci. All rights reserved.
//

import UIKit
import CoreData

class NewMemberViewController: UIViewController {
    let scrollView  = UIScrollView()
    let contentView = UIStackView()

    var nameLabel         = UILabel()
    var positionLabel     = UILabel()
    var ageLabel         = UILabel()
    var locationLabel       = UILabel()
    var yearsInHipoLabel = UILabel()
    var githubLabel     = UILabel()

    var saveButton = UIButton()

    var nameTextField = UITextField()
    var positionTextField = UITextField()
    var ageTextField = UITextField()
    var locationTextField = UITextField()
    var yearsInHipoTextField = UITextField()
    var githubTextField = UITextField()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = NSLocalizedString(LocalizedStrings.addNewMember.rawValue , comment: "")

        nameTextField.delegate = self
        positionTextField.delegate = self
        locationTextField.delegate = self
        githubTextField.delegate = self
        yearsInHipoTextField.delegate = self
        ageTextField.delegate = self

        setupScrollView()
        setupContentView()
        setupLabel()
        labelUI()
        setupTextField()
        textFieldUI()
        setupSaveButton()

        saveButton.addTarget(self, action:#selector(self.saveNewMemberButtonClicked), for: .touchUpInside)
    }

    //MARK: - Add New Member Button Click
    @objc func saveNewMemberButtonClicked(_ sender: UIButton?) {
        print("Add New Member Save Button Clicked")
        saveLocalData()
    }

    private func setupScrollView() {

        scrollView.backgroundColor = .white

        view.addSubview(scrollView)

        scrollView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    private func setupContentView() {

        contentView.axis            = .vertical
        contentView.distribution    = .fill
        contentView.alignment       = .fill
        contentView.spacing = 8

        scrollView.addSubview(contentView)

        contentView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25),
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)
        ])
    }

    private func setupLabel() {
        NSLayoutConstraint.activate([
            nameLabel.heightAnchor.constraint(equalToConstant: 30),
            nameLabel.heightAnchor.constraint(equalToConstant: 30),
            positionLabel.heightAnchor.constraint(equalToConstant: 30),
            ageLabel.heightAnchor.constraint(equalToConstant: 30),
            locationLabel.heightAnchor.constraint(equalToConstant: 30),
            yearsInHipoLabel.heightAnchor.constraint(equalToConstant: 30),
            githubLabel.heightAnchor.constraint(equalToConstant: 30)
        ])

        nameLabel.text = NSLocalizedString(LocalizedStrings.name.rawValue, comment: "")
        positionLabel.text = NSLocalizedString(LocalizedStrings.position.rawValue, comment: "")
        ageLabel.text = NSLocalizedString(LocalizedStrings.age.rawValue, comment: "")
        locationLabel.text = NSLocalizedString(LocalizedStrings.location.rawValue, comment: "")
        yearsInHipoLabel.text = NSLocalizedString(LocalizedStrings.numberOfYearsInHipo.rawValue, comment: "")
        githubLabel.text = NSLocalizedString(LocalizedStrings.github.rawValue, comment: "")
    }

    //MARK: - labelUI
    func labelUI() {
        [nameLabel, positionLabel, ageLabel, locationLabel, yearsInHipoLabel, githubLabel].forEach {
            $0.font = $0.font.withSize(13)
            $0.textColor = .black
        }
    }

    private func setupTextField() {
        nameTextField.placeholder =         NSLocalizedString(LocalizedStrings.pleaseEnterYourName.rawValue, comment: "")
        positionTextField.placeholder =     NSLocalizedString(LocalizedStrings.pleaseEnterYourPosition.rawValue,comment: "")
        ageTextField.placeholder =          NSLocalizedString(LocalizedStrings.pleaseEnterYourAge.rawValue, comment: "")
        locationTextField.placeholder =     NSLocalizedString(LocalizedStrings.pleaseEnterYourLocation.rawValue, comment: "")
        yearsInHipoTextField.placeholder =  NSLocalizedString(LocalizedStrings.pleaseEnterYourHipoYear.rawValue, comment: "")
        githubTextField.placeholder =       NSLocalizedString(LocalizedStrings.github.rawValue, comment: "")
        [nameTextField, positionTextField, ageTextField, locationTextField, yearsInHipoTextField, githubTextField].forEach {
            NSLayoutConstraint.activate([
                $0.heightAnchor.constraint(equalToConstant: 50),
                $0.widthAnchor.constraint(equalToConstant: 300)
            ])
        }
        contentView.addArrangedSubview(nameLabel)
        contentView.addArrangedSubview(nameTextField)
        contentView.addArrangedSubview(positionLabel)
        contentView.addArrangedSubview(positionTextField)
        contentView.addArrangedSubview(ageLabel)
        contentView.addArrangedSubview(ageTextField)
        contentView.addArrangedSubview(locationLabel)
        contentView.addArrangedSubview(locationTextField)
        contentView.addArrangedSubview(yearsInHipoLabel)
        contentView.addArrangedSubview(yearsInHipoTextField)
        contentView.addArrangedSubview(githubLabel)
        contentView.addArrangedSubview(githubTextField)
    }

    //MARK: - textFieldUI
    func textFieldUI() {
        [nameTextField, positionTextField, ageTextField, locationTextField, yearsInHipoTextField, githubTextField].forEach {
            $0.font = UIFont.systemFont(ofSize: 15)
            $0.backgroundColor = .systemGray6
            $0.borderStyle = UITextField.BorderStyle.roundedRect
            $0.autocorrectionType = UITextAutocorrectionType.no
            $0.keyboardType = UIKeyboardType.default
            $0.returnKeyType = UIReturnKeyType.done
            $0.clearButtonMode = UITextField.ViewMode.whileEditing
            $0.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        }
    }

    private func setupSaveButton() {
        contentView.addArrangedSubview(saveButton)
        saveButton.setTitle("SAVE", for: .normal)
        saveButton.backgroundColor = UIColor(red:0.18, green:0.73, blue:0.31, alpha:1.0)
        saveButton.layer.cornerRadius = 25
        NSLayoutConstraint.activate([
            saveButton.topAnchor.constraint(equalTo: githubTextField.bottomAnchor, constant: 77),
            saveButton.widthAnchor.constraint(equalToConstant: 285),
            saveButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }

    //MARK: - Save User Defaults
    func saveUserDefaults() {
        let defaults = UserDefaults.standard
        defaults.set(self.nameTextField.text, forKey: "nameTextField")
        defaults.set(self.ageTextField.text, forKey: "ageTextField")
        defaults.set(self.locationTextField.text, forKey: "locationTextField")
        defaults.set(self.githubTextField.text, forKey: "githubTextField")
        defaults.set(self.positionTextField.text, forKey: "positionTextField")
        defaults.set(self.yearsInHipoTextField.text, forKey: "yearsInHipoTextField")
    }

    //MARK: - Get User Defaults
    func getUserDefaults() {
        let defaults = UserDefaults.standard
        if let name = defaults.string(forKey: "nameTextField"){
            nameTextField.text = name
        }
        if let age = defaults.string(forKey: "ageTextField"){
            ageTextField.text = age
        }
        if let location = defaults.string(forKey: "locationTextField"){
            locationTextField.text = location
        }
        if let github = defaults.string(forKey: "githubTextField"){
            githubTextField.text = github
        }
        if let position = defaults.string(forKey: "positionTextField"){
            positionTextField.text = position
        }
        if let years = defaults.string(forKey: "yearsInHipoTextField"){
            yearsInHipoTextField.text = years
        }
    }

    //MARK: - Save localdata(CoreData)
    func saveLocalData() {

        //UserDefaults
        saveUserDefaults()

        //CoreData
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let saveNewMember = NSEntityDescription.insertNewObject(forEntityName: "HipoMember", into: context)
        saveNewMember.setValue(nameTextField.text, forKey: "name")
        saveNewMember.setValue(Int(ageTextField.text ?? "0"), forKey: "age")
        saveNewMember.setValue(locationTextField.text!, forKey: "location")
        saveNewMember.setValue(githubTextField.text!, forKey: "github")
        saveNewMember.setValue(positionTextField.text!, forKey: "position")
        saveNewMember.setValue(Int(yearsInHipoTextField.text ?? "0"), forKey: "years_in_hipo")
        do {
            try context.save()

            let titleSaved = NSLocalizedString(LocalizedStrings.capitalizedSaved.rawValue, comment: "")
            let messageSaved = NSLocalizedString(LocalizedStrings.newMemberSavedSuccessfully.rawValue, comment: "")

            let titleOK = NSLocalizedString(LocalizedStrings.capitalizedOk.rawValue, comment: "")

            let alert = UIAlertController (title: titleSaved, message: messageSaved, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: titleOK, style: .cancel, handler:{ (alertOKAction) in
                self.dismiss(animated: false, completion: nil)
                self.navigationController!.popToRootViewController(animated: true)
            }))
            self.present(alert, animated: true, completion: nil)
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "newData"), object: nil)

            print("Success!")
        } catch {

            let titleError = NSLocalizedString(LocalizedStrings.error.rawValue, comment: "")
            let messageError = NSLocalizedString(LocalizedStrings.newMemberDoesNotSavedSuccessfully.rawValue, comment: "")

            self.showAlert(withTitle: titleError, withMessage: messageError)
            print(error.localizedDescription)
        }
    }
}

extension NewMemberViewController: UITextFieldDelegate {
    //MARK: - Textfield Range
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == nameTextField || textField == positionTextField || textField == locationTextField {
            let allowedCharacters = LocalizedStrings.allowedCharacters.rawValue
            let allowedCharacterSet = CharacterSet(charactersIn: allowedCharacters)
            let typedCharacterSet = CharacterSet(charactersIn: string)
            let alphabet = allowedCharacterSet.isSuperset(of: typedCharacterSet)
            return alphabet
        } else if textField == ageTextField || textField == yearsInHipoTextField {
            let allowedCharacters = CharacterSet.decimalDigits
            let characterSet = CharacterSet(charactersIn: string)
            return allowedCharacters.isSuperset(of: characterSet)
        }
        else if textField == githubTextField {
            let allowedCharacters = LocalizedStrings.allowedCharactersWithSpecialized.rawValue
            let allowedCharacterSet = CharacterSet(charactersIn: allowedCharacters)
            let typedCharacterSet = CharacterSet(charactersIn: string)
            let all = allowedCharacterSet.isSuperset(of: typedCharacterSet)
            return all
        }
        else {
            return false
        }
    }
}
