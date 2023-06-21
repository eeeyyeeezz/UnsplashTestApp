//
//  SearchCollectionView.swift
//  UnsplashTestApp
//
//  Created by Даниил Назаров on 20.06.2023.
//

import UIKit

class PhotosCollectionView: UICollectionView {

	init(frame: CGRect) {
		let layout = UICollectionViewFlowLayout()
		layout.scrollDirection = .vertical
		
		super.init(frame: frame, collectionViewLayout: layout)
		backgroundColor = .white
		register(PhotoCell.self, forCellWithReuseIdentifier: PhotoCell.identifier)
 		translatesAutoresizingMaskIntoConstraints = false
	}

	@available(*, unavailable)
	required init?(coder _: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
