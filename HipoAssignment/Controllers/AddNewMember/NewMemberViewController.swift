//
//  NewMemberViewController.swift
//  HipoAssignment
//
//  Created by Ali Emre Değirmenci on 23.04.2020.
//  Copyright © 2020 Ali Emre Degirmenci. All rights reserved.
//

import UIKit

class NewMemberViewController: UIViewController {
    let stackView = UIStackView()
    let scrollView = UIScrollView()
    let label = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(label)
        view.addSubview(scrollView)
        view.addSubview(stackView)

        label.translatesAutoresizingMaskIntoConstraints = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.addSubview(label)
        scrollView.addSubview(stackView)
    }

}
