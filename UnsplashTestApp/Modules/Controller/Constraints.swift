//
//  Constraints.swift
//  UnsplashTestApp
//
//  Created by Даниил Назаров on 21.06.2023.
//

import UIKit

extension ViewController {
	func setupConstraints() {
		searchButtonTopConstraint = searchButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -16)
		NSLayoutConstraint.activate([
			searchButtonTopConstraint,
			searchButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
			searchButton.widthAnchor.constraint(equalToConstant: 82),
			searchButton.heightAnchor.constraint(equalToConstant: 48)
		])
		
		textFieldTopConstraint = textField.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -16)
		NSLayoutConstraint.activate([
			textField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
			textFieldTopConstraint,
			textField.trailingAnchor.constraint(equalTo: searchButton.leadingAnchor, constant: -10),
			textField.heightAnchor.constraint(equalToConstant: 48)
		])
		
		collectionViewTopConstraint = collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
		NSLayoutConstraint.activate([
			collectionViewTopConstraint,
			collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
			collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
			collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
		])
		
	}
	
	func configureConstraints() {
		if !constraintsAreStable {
			collectionViewTopConstraint.isActive = false
			searchButtonTopConstraint.isActive = false
			textFieldTopConstraint.isActive = false
			
			collectionView.isHidden = false
			
			UIView.animate(withDuration: 0.3) { [weak self] in
				guard let self = self else { return }
				NSLayoutConstraint.activate([
					searchButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
					textField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
					collectionView.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 32),
					
					failureLabel.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 56),
					failureLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
					failureLabel.heightAnchor.constraint(equalToConstant: 19),
					failureLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor)
				])
				view.layoutIfNeeded()
			}
			constraintsAreStable = true
		}
	}
}

