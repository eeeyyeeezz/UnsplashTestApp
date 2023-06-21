//
//  SearchCollectionView.swift
//  UnsplashTestApp
//
//  Created by Даниил Назаров on 20.06.2023.
//

import UIKit

class PhotoCell: UICollectionViewCell {
	
	static let identifier = "PhotoCell"
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		layer.cornerRadius = 5
		backgroundColor = .orange
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
}


class PhotosCollectionView: UICollectionView {

	init(frame: CGRect) {
		let layout = UICollectionViewFlowLayout()
//		layout.itemSize = CGSize(width: frame.width / 3, height: 100)
//		layout.minimumInteritemSpacing = 0
//		layout.minimumLineSpacing = 0
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
