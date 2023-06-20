//
//  ViewController.swift
//  UnsplashTestApp
//
//  Created by Даниил Назаров on 20.06.2023.
//

import UIKit

final class ViewController: UIViewController {

	private let textField = MessageTextField()
	
	private lazy var collectionView = PhotosCollectionView(frame: view.frame)
	
	private var searchButtonTopConstraint = NSLayoutConstraint()
	
	private var textFieldTopConstraint = NSLayoutConstraint()
	
	private lazy var searchButton: UIButton = {
		let button = UIButton()
		button.layer.cornerRadius = 12
		button.titleLabel?.textColor = #colorLiteral(red: 0.9999999404, green: 1, blue: 1, alpha: 1)
		button.backgroundColor = #colorLiteral(red: 0.9232862592, green: 0.04007609934, blue: 0.04480296373, alpha: 1)
		button.setTitle("Искать", for: .normal)
		button.addTarget(self, action: #selector(searchButtonTapped), for: .touchUpInside)
		button.translatesAutoresizingMaskIntoConstraints = false
		return button
	}()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		setupBinding()
		setupConstraints()
	}
	
	private func setupBinding() {
		textField.delegate = self
		
		view.addSubview(searchButton)
		view.addSubview(textField)
	}
	
	private func setupConstraints() {
		searchButtonTopConstraint = searchButton.centerYAnchor.constraint(equalTo: view.centerYAnchor)
		NSLayoutConstraint.activate([
			searchButtonTopConstraint,
			searchButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
			searchButton.widthAnchor.constraint(equalToConstant: 100),
			searchButton.heightAnchor.constraint(equalToConstant: 50)
		])
		
		textFieldTopConstraint = textField.centerYAnchor.constraint(equalTo: view.centerYAnchor)
		NSLayoutConstraint.activate([
			textField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
			textFieldTopConstraint,
			textField.trailingAnchor.constraint(equalTo: searchButton.leadingAnchor, constant: -10),
			textField.heightAnchor.constraint(equalToConstant: 50)
		])
	}
	
	@objc private func searchButtonTapped() {
		searchButtonTopConstraint.isActive = false
		textFieldTopConstraint.isActive = false
		UIView.animate(withDuration: 0.3) { [weak self] in
			guard let self = self else { return }
			searchButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
			textField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
			view.layoutIfNeeded()
		}
		
		
	}


}

extension ViewController: UITextFieldDelegate {
	
	// Проверяем что написали в TextField
	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		if let text = textField.text, !text.isEmpty {
			debugPrint(text)
		}
		textField.text = nil
		return true
	}
}

