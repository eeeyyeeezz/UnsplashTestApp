//
//  SearchCollectionView.swift
//  UnsplashTestApp
//
//  Created by Даниил Назаров on 20.06.2023.
//

import UIKit

fileprivate class PhotoCell: UICollectionViewCell {
	
	fileprivate static let identifier = "DraftCell"
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		layer.cornerRadius = 20
		backgroundColor = .orange
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
}


class PhotosCollectionView: UICollectionView {

	init(frame: CGRect) {
		let layout = UICollectionViewFlowLayout()
		layout.scrollDirection = .vertical
		super.init(frame: frame, collectionViewLayout: layout)
		delegate = self
		dataSource = self
		backgroundColor = .white
		register(PhotoCell.self, forCellWithReuseIdentifier: PhotoCell.identifier)
 		translatesAutoresizingMaskIntoConstraints = false
	}

	@available(*, unavailable)
	required init?(coder _: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

extension PhotosCollectionView: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int { 10 }
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = dequeueReusableCell(withReuseIdentifier: PhotoCell.identifier, for: indexPath) as! PhotoCell
		return cell
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		CGSize(width: frame.width, height: frame.height / 6.5)
	}
	
}
