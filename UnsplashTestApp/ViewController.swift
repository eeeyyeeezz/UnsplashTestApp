//
//  ViewController.swift
//  UnsplashTestApp
//
//  Created by Даниил Назаров on 20.06.2023.
//

import UIKit

final class ViewController: UIViewController {

	private let textField = MessageTextField()
	
	private let searchButton: UIButton = {
		let button = UIButton()
		button.layer.cornerRadius = 12
		button.titleLabel?.textColor = #colorLiteral(red: 0.9999999404, green: 1, blue: 1, alpha: 1)
		button.backgroundColor = #colorLiteral(red: 0.9232862592, green: 0.04007609934, blue: 0.04480296373, alpha: 1)
		button.setTitle("Искать", for: .normal)
		button.translatesAutoresizingMaskIntoConstraints = false
		return button
	}()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		setupBinding()
		setupConstraints()
	}
	
	private func setupBinding() {
		view.addSubview(searchButton)
		view.addSubview(textField)
	}
	
	private func setupConstraints() {
		NSLayoutConstraint.activate([
			searchButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
			searchButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
			searchButton.widthAnchor.constraint(equalToConstant: 100),
			searchButton.heightAnchor.constraint(equalToConstant: 50)
		])
		
		
		NSLayoutConstraint.activate([
			textField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
			textField.centerYAnchor.constraint(equalTo: view.centerYAnchor),
			textField.trailingAnchor.constraint(equalTo: searchButton.leadingAnchor, constant: -10),
			textField.heightAnchor.constraint(equalToConstant: 50)
		])
	}


}

