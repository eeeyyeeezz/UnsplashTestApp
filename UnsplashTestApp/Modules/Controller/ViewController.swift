//
//  ViewController.swift
//  UnsplashTestApp
//
//  Created by Даниил Назаров on 20.06.2023.
//

import UIKit

final class ViewController: UIViewController {
	
	private lazy var activityIndicator: UIActivityIndicatorView = {
		let activityIndicator = UIActivityIndicatorView(style: .medium)
		activityIndicator.color = .black
		activityIndicator.startAnimating()
		activityIndicator.center = view.center
		return activityIndicator
	}()

	let textField = MessageTextField()
	
	lazy var collectionView = PhotosCollectionView(frame: view.frame)
	
	/// Все три переменнные нужны для изменения констрейтов
	var searchButtonTopConstraint = NSLayoutConstraint()
	
	var textFieldTopConstraint = NSLayoutConstraint()
	
	var collectionViewTopConstraint = NSLayoutConstraint()
	
	/// Переменная нужна чтобы не вызывать каждый раз изменение констрейтов после первого ввода
	var constraintsAreStable = false
	
	/// Кэш для ячеек с картинками
	var imageCacheForCells: [URL: UIImage] = [:]
	
	var textSearch = ""
	
	var models = [URL]()
	
	lazy var searchButton: UIButton = {
		let button = UIButton()
		button.layer.cornerRadius = 12
		button.titleLabel?.textColor = #colorLiteral(red: 0.9999999404, green: 1, blue: 1, alpha: 1)
		button.backgroundColor = #colorLiteral(red: 0.9232862592, green: 0.04007609934, blue: 0.04480296373, alpha: 1)
		button.setTitle("Искать", for: .normal)
		button.addTarget(self, action: #selector(searchButtonTapped), for: .touchUpInside)
		button.translatesAutoresizingMaskIntoConstraints = false
		return button
	}()
	
	let failureLabel: UILabel = {
		let label = UILabel()
		label.textColor = #colorLiteral(red: 0.4705882668, green: 0.4705882668, blue: 0.4705882668, alpha: 1)
		label.isHidden = true
		label.adjustsFontSizeToFitWidth = true
		label.font = label.font.withSize(16)
		label.text = "К сожалению, поиск не дал результатов"
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()
	
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		setupBinding()
		setupConstraints()
	}
	
	private func setupBinding() {
		textField.delegate = self
		collectionView.isHidden = true
		
		collectionView.delegate = self
		collectionView.dataSource = self
		view.addSubview(collectionView)
		view.addSubview(failureLabel)
		view.addSubview(searchButton)
		view.addSubview(textField)
	}
	
	
	@objc private func searchButtonTapped() {
		models = []
		configureConstraints()
		loadModels(textSearch)
		textField.text = ""
	}
	
	/// Если прятать activityIndicator под isHidden = true то цвет черным не становится поэтому нужно каждый раз добавлять заново на вью
	/// Походу это говнокод зато работает лол
	/// Если знаете как пофиксить чтобы по человечески с ishidden = true работало то отправьте почтового голубя
	func loadModels(_ response: String) {
		models = []
		NetworkManager.paginationCounter = 1
		textField.resignFirstResponder()
		failureLabel.isHidden = true
		collectionView.reloadData()
		view.addSubview(activityIndicator)
		fetchData(response)
	}
	
	func fetchData(_ response: String) {
		NetworkManager.loadPhotos(searchResponse: response) { [weak self] result in
			guard let self = self else { return }
			switch result {
				case .success(let photoURLs):
				self.models.append(contentsOf: photoURLs)
				debugPrint("Фотографий всего \(self.models.count) в кэше \(self.imageCacheForCells.count)")
					DispatchQueue.main.async {
						if self.models.count == 0 {
							self.failureLabel.isHidden = false
						} else {
							self.collectionView.reloadData()
						}
						self.activityIndicator.removeFromSuperview()
					}
				case .failure(let error):
					guard models.isEmpty else { return }
					DispatchQueue.main.async {
						self.activityIndicator.removeFromSuperview()
						self.failureLabel.isHidden = false
					}
					debugPrint("Не удалось загрузить фотографии: \(error)")
				}
		}
	}


}

extension ViewController: UITextFieldDelegate {
	
	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		if let text = textField.text, !text.isEmpty {
			debugPrint(text)
			NetworkManager.paginationCounter = 1
			models = []
			configureConstraints()
			collectionView.reloadData()
			loadModels(text)
			textField.text = ""
		}
		textField.text = nil
		return true
	}
	
	func textFieldDidChangeSelection(_ textField: UITextField) {
		if let text = textField.text {
			textSearch = text
		}
	}
	
}

