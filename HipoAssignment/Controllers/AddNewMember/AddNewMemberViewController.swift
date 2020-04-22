//
//  AddNewMemberViewController.swift
//  HipoAssignment
//
//  Created by Ali Emre Değirmenci on 26.02.2020.
//  Copyright © 2020 Ali Emre Degirmenci. All rights reserved.
//

import UIKit
import CoreData

class AddNewMemberViewController: UIViewController, UITextFieldDelegate {

    private var nameArray = [String]()
    private var positionArray = [String]()
    private var ageArray = [Int]()
    private var locationArray = [String]()
    private var yearsInHipoArray = [Int]()
    private var githubArray = [String]()

    //UI Components
    lazy private var nameLabel = UILabel()
    lazy private var positionLabel = UILabel()
    lazy private var ageLabel = UILabel()
    lazy private var locationLabel = UILabel()
    lazy private var yearsInHipoLabel = UILabel()
    lazy private var githubLabel = UILabel()
    lazy private var saveButton = UIButton()
    lazy private var scrollView: UIScrollView = {
        let view = UIScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentSize.height = 900
        view.backgroundColor = .white

        return view
    }()

    lazy private var nameTextField = UITextField()
    lazy private var positionTextField = UITextField()
    lazy private var ageTextField = UITextField()
    lazy private var locationTextField = UITextField()
    lazy private var yearsInHipoTextField = UITextField()
    lazy private var githubTextField = UITextField()

    private var safeArea: UILayoutGuide!

    // MARK: - View's Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = NSLocalizedString("Add New Member", comment: "")

        nameTextField.delegate = self
        positionTextField.delegate = self
        locationTextField.delegate = self
        githubTextField.delegate = self
        yearsInHipoTextField.delegate = self
        ageTextField.delegate = self

        setupView()
        getUserDefaults()

        saveButton.addTarget(self, action:#selector(self.saveNewMemberButtonClicked), for: .touchUpInside)
    }

    //MARK: - Add New Member Button Click
    @objc func saveNewMemberButtonClicked(_ sender: UIButton?) {
        print("Add New Member Save Button Clicked")
        saveLocalData()
    }

    //MARK: - Textfield Range
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == nameTextField || textField == positionTextField || textField == locationTextField {
            let allowedCharacters = "ABCÇDEFGĞHIİJKLMNOÖPQRSŞTUÜVWXYZabcçdefgğhıijklmnoöpqrstuüvwxyz "
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
            let allowedCharacters = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789-_!'^+%&/()=?,;:."
            let allowedCharacterSet = CharacterSet(charactersIn: allowedCharacters)
            let typedCharacterSet = CharacterSet(charactersIn: string)
            let all = allowedCharacterSet.isSuperset(of: typedCharacterSet)
            return all
        }
        else {
            return false
        }
    }

    //MARK: - Setup View
    func setupView() {
        viewAddSubView()
        scrollView.backgroundColor = .systemBackground
        [scrollView, saveButton].forEach { $0.translatesAutoresizingMaskIntoConstraints = false}

        labelUI()
        labelConstraints()
        textFieldUI()
        textFieldConstraints()
        scrollViewConstraints()

        scrollViewAddSubView()

        activateAllConstraints()

        nameLabel.text = NSLocalizedString("Name:", comment: "")
        nameTextField.placeholder = NSLocalizedString("Please enter your name", comment: "")
        positionLabel.text = NSLocalizedString("Position:", comment: "")
        positionTextField.placeholder = NSLocalizedString("Please enter your position",comment: "")
        ageLabel.text = NSLocalizedString("Age:", comment: "")
        ageTextField.placeholder = NSLocalizedString("Please enter your age", comment: "")
        locationLabel.text = NSLocalizedString("Location:", comment: "")
        locationTextField.placeholder = NSLocalizedString("Please enter your location", comment: "")
        yearsInHipoLabel.text = NSLocalizedString("Number of years in Hipo:", comment: "")
        yearsInHipoTextField.placeholder = NSLocalizedString("Please enter how many years you worked in Hipo", comment: "")
        githubLabel.text = NSLocalizedString("Github:", comment: "")
        githubTextField.placeholder = NSLocalizedString("Please enter your Github username", comment: "")
        saveButtonConstraints()
    }

    //MARK: - activateAllConstraints
    func activateAllConstraints() {
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 20),
            nameTextField.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 40),
            positionLabel.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 100),
            positionTextField.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 120),
            ageLabel.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 180),
            ageTextField.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 200),
            locationLabel.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 260),
            locationTextField.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 280),
            yearsInHipoLabel.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 340),
            yearsInHipoTextField.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 360),
            githubLabel.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 420),
            githubTextField.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 440)
        ])
    }

    //MARK: - viewAddSubView()
    func viewAddSubView() {
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
    }

    //MARK: - scrollViewAddSubView
    func scrollViewAddSubView() {
        scrollView.addSubview(nameLabel)
        scrollView.addSubview(nameTextField)
        scrollView.addSubview(positionLabel)
        scrollView.addSubview(positionTextField)
        scrollView.addSubview(ageLabel)
        scrollView.addSubview(ageTextField)
        scrollView.addSubview(locationLabel)
        scrollView.addSubview(locationTextField)
        scrollView.addSubview(yearsInHipoLabel)
        scrollView.addSubview(yearsInHipoTextField)
        scrollView.addSubview(githubLabel)
        scrollView.addSubview(githubTextField)
        scrollView.addSubview(saveButton)
    }

    //MARK: - labelUI
    func labelUI() {
        [nameLabel, positionLabel, ageLabel, locationLabel, yearsInHipoLabel, githubLabel].forEach {
            $0.font = $0.font.withSize(13)
            $0.textColor = .black
        }
    }

    //MARK: - labelConstraints
    func labelConstraints() {
        [nameLabel, positionLabel, ageLabel, locationLabel, yearsInHipoLabel, githubLabel].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
            $0.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 30).isActive = true
        }
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

    //MARK: - textFieldConstraints
    func textFieldConstraints() {
        [nameTextField, positionTextField, ageTextField, locationTextField, yearsInHipoTextField, githubTextField].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
            $0.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25).isActive = true
            $0.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15).isActive = true
        }
    }

    //MARK: - scrollViewConstraints
    func scrollViewConstraints() {
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }

    //MARK: - add new member button layouts
    func saveButtonConstraints() {
        saveButton.setTitle("SAVE", for: .normal)
        saveButton.backgroundColor = UIColor(red:0.18, green:0.73, blue:0.31, alpha:1.0)
        saveButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50).isActive = true
        saveButton.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: 560).isActive = true
        saveButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50).isActive = true
        saveButton.widthAnchor.constraint(equalToConstant: 285).isActive = true
        saveButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        saveButton.layer.cornerRadius = 25
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

            let titleSaved = NSLocalizedString("SAVED", comment: "")
            let messageSaved = NSLocalizedString("New member saved successfully!", comment: "")

            let titleOK = NSLocalizedString("OK", comment: "")

            let alert = UIAlertController (title: titleSaved, message: messageSaved, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: titleOK, style: .cancel, handler:{ (alertOKAction) in
                self.dismiss(animated: false, completion: nil)
                self.navigationController!.popToRootViewController(animated: true)
            }))
            self.present(alert, animated: true, completion: nil)
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "newData"), object: nil)

            print("Success!")
        } catch {

            let titleError = NSLocalizedString("Error", comment: "")
            let messageError = NSLocalizedString("New member does not saved successfully!", comment: "")

            self.showAlert(withTitle: titleError, withMessage: messageError)
            print(error.localizedDescription)
        }
    }
}
