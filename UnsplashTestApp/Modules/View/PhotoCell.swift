//
//  PhotoCell.swift
//  UnsplashTestApp
//
//  Created by Даниил Назаров on 21.06.2023.
//

import UIKit

class PhotoCell: UICollectionViewCell {
	
	static let identifier = "PhotoCell"

	lazy var imageView: UIImageView = {
		let image = UIImageView()
		image.frame = bounds
		image.clipsToBounds = true
		image.layer.cornerRadius = 5
		image.contentMode = .scaleAspectFit
		return image
	}()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		layer.cornerRadius = 5
		layer.borderWidth = 2
		layer.borderColor = #colorLiteral(red: 0.9215685725, green: 0.9215685725, blue: 0.9215685725, alpha: 1)
		backgroundColor = #colorLiteral(red: 0.9999999404, green: 1, blue: 1, alpha: 1)
		addSubview(imageView)
	}
	
	override func prepareForReuse() {
		super.prepareForReuse()
		imageView.image = nil
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
}
