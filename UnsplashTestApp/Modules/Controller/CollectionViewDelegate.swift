//
//  CollectionViewDelegate.swift
//  UnsplashTestApp
//
//  Created by Даниил Назаров on 21.06.2023.
//

import UIKit

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int { models.count }
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCell.identifier, for: indexPath) as! PhotoCell
		
		let url = models[indexPath.row]
		downloadImage(url) { image in
			DispatchQueue.main.async {
				cell.imageView.image = image
			}
		}

		/// Пагинация
		if indexPath.row == models.count - 1 {
			debugPrint("textSearch \(textSearch)")
			DispatchQueue.global().async { [weak self] in
				guard let self = self else { return }
				self.fetchData(self.textSearch)
			}
		}
		
		return cell
	}
	
	private func downloadImage(_ url: URL, completion: @escaping (UIImage?) -> ()) {
		if let cachedImage = imageCacheForCells[url] {
			completion(cachedImage)
			return
		}
		
		DispatchQueue.global().async {
			NetworkManager.parseAndLoadImage(fromURL: url) { [weak self] result in
				switch result {
				case .success(let data):
						let image = UIImage(data: data)
						self?.imageCacheForCells[url] = image
						completion(image)
				case .failure(let error):
					debugPrint("Ошибка при загрузке изображения: \(error)")
				}
			}
		}
	}
	
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		guard let cell = collectionView.cellForItem(at: indexPath) as? PhotoCell else { return }
		let imageVC = ImageViewController()
		imageVC.imageView.image = cell.imageView.image
		present(imageVC, animated: true, completion: nil)

	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		let width = (collectionView.frame.width / 3) - 6
		let height = width
		return CGSize(width: width, height: height)
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
		return 8
	}

	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
		return 8
	}
	
}

