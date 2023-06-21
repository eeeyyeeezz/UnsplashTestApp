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

	lazy var image: UIImageView = {
		let image = UIImageView(image: nil)
		image.contentMode = .scaleToFill
		image.frame = bounds
		return image
	}()
	
	private lazy var activityIndicator: UIActivityIndicatorView = {
		let activity = UIActivityIndicatorView(style: .medium)
		activity.color = .black
		activity.startAnimating()
		activity.center = center
		return activity
	}()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		layer.cornerRadius = 5
		backgroundColor = #colorLiteral(red: 0.9999999404, green: 1, blue: 1, alpha: 1)
	}
	
	override func layoutSubviews() {
		super.layoutSubviews()
		addSubview(activityIndicator)
		addSubview(image)
		downloadImage()
	}
	
	override func prepareForReuse() {
		super.prepareForReuse()
		activityIndicator.removeFromSuperview()
		addSubview(activityIndicator)
		image.image = nil
	}
	
	private func downloadImage() {
		guard let url = imageUrl else { return }
		NetworkManager.parseAndLoadImage(fromURL: url) { [weak self] result in
			switch result {
			   case .success(let data):
					DispatchQueue.main.async {
						self?.activityIndicator.isHidden = true
						self?.image.image = UIImage(data: data)
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
