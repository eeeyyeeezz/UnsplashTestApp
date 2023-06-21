//
//  CellViewController.swift
//  UnsplashTestApp
//
//  Created by Даниил Назаров on 21.06.2023.
//

import UIKit

class ImageViewController: UIViewController {
	
	let image: UIImageView = {
		let image = UIImageView()
		image.translatesAutoresizingMaskIntoConstraints = false
		return image
	}()
	
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		view.backgroundColor = .white
		view.addSubview(image)
		NSLayoutConstraint.activate([
			image.topAnchor.constraint(equalTo: view.topAnchor),
			image.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			image.trailingAnchor.constraint(equalTo: view.trailingAnchor),
			image.bottomAnchor.constraint(equalTo: view.centerYAnchor)
		])
	}
	
}
