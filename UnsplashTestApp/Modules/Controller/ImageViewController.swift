//
//  CellViewController.swift
//  UnsplashTestApp
//
//  Created by Даниил Назаров on 21.06.2023.
//

import UIKit

class ImageViewController: UIViewController {
	
	let imageView: UIImageView = {
		let image = UIImageView()
		image.alpha = 0.3
		image.translatesAutoresizingMaskIntoConstraints = false
		return image
	}()
	
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		view.backgroundColor = .white
		view.addSubview(imageView)
		NSLayoutConstraint.activate([
			imageView.topAnchor.constraint(equalTo: view.topAnchor),
			imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
			imageView.bottomAnchor.constraint(equalTo: view.centerYAnchor)
		])
		
		UIView.animate(withDuration: 0.3) {
			self.imageView.alpha = 1
		}
	}
	
}
