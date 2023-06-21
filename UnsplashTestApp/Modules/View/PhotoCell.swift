//
//  PhotoCell.swift
//  UnsplashTestApp
//
//  Created by Даниил Назаров on 21.06.2023.
//

import UIKit

class PhotoCell: UICollectionViewCell {
	
	static let identifier = "PhotoCell"
	
	var imageUrl: URL?

	lazy var imageView: UIImageView = {
		let image = UIImageView(image: nil)
		image.contentMode = .scaleToFill
		image.frame = bounds
		image.alpha = 0
		image.clipsToBounds = true
		image.layer.cornerRadius = 5
		return image
	}()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		layer.cornerRadius = 5
		layer.borderWidth = 2
		layer.borderColor = #colorLiteral(red: 0.9215685725, green: 0.9215685725, blue: 0.9215685725, alpha: 1)
		backgroundColor = #colorLiteral(red: 0.9999999404, green: 1, blue: 1, alpha: 1)
	}
	
	override func layoutSubviews() {
		super.layoutSubviews()
		addSubview(imageView)
		downloadImage()
	}
	
	override func prepareForReuse() {
		super.prepareForReuse()
		imageView.alpha = 0
		imageView.image = nil
	}
	
	private func downloadImage() {
		guard let url = imageUrl else { return }
		NetworkManager.parseAndLoadImage(fromURL: url) { [weak self] result in
			switch result {
			   case .success(let data):
					DispatchQueue.main.async {
						self?.imageView.image = UIImage(data: data)
						UIView.animate(withDuration: 0.5) {
							self?.imageView.alpha = 1
						}
					}
			   case .failure(let error):
				   debugPrint("Ошибка при загрузке изображения: \(error)")
			   }
		}
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
}
