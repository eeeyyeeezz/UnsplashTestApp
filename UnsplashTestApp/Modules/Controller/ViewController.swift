//
//  ViewController.swift
//  UnsplashTestApp
//
//  Created by Даниил Назаров on 20.06.2023.
//

import UIKit

final class ViewController: UIViewController {

	private let textField = MessageTextField()
	
	private lazy var collectionView = PhotosCollectionView(frame: view.frame)
	
	private lazy var activityIndicator: UIActivityIndicatorView = {
		let activityIndicator = UIActivityIndicatorView(style: .medium)
		activityIndicator.color = .black
		activityIndicator.startAnimating()
		activityIndicator.center = view.center
		return activityIndicator
	}()
	
	/// Все три переменнные нужны для изменения констрейтов
	private var searchButtonTopConstraint = NSLayoutConstraint()
	
	private var textFieldTopConstraint = NSLayoutConstraint()
	
	private var collectionViewTopConstraint = NSLayoutConstraint()
	
	private var textSearch = ""
	
	/// Переменная нужна чтобы не вызывать каждый раз изменение констрейтов после первого ввода
	private var constraintsAreStable = false
	
	var models = [URL]()
	
	private lazy var searchButton: UIButton = {
		let button = UIButton()
		button.layer.cornerRadius = 12
		button.titleLabel?.textColor = #colorLiteral(red: 0.9999999404, green: 1, blue: 1, alpha: 1)
		button.backgroundColor = #colorLiteral(red: 0.9232862592, green: 0.04007609934, blue: 0.04480296373, alpha: 1)
		button.setTitle("Искать", for: .normal)
		button.addTarget(self, action: #selector(searchButtonTapped), for: .touchUpInside)
		button.translatesAutoresizingMaskIntoConstraints = false
		return button
	}()
	
	private let failureLabel: UILabel = {
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
	
	private func setupConstraints() {
		searchButtonTopConstraint = searchButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -16)
		NSLayoutConstraint.activate([
			searchButtonTopConstraint,
			searchButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
			searchButton.widthAnchor.constraint(equalToConstant: 82),
			searchButton.heightAnchor.constraint(equalToConstant: 48)
		])
		
		textFieldTopConstraint = textField.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -16)
		NSLayoutConstraint.activate([
			textField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
			textFieldTopConstraint,
			textField.trailingAnchor.constraint(equalTo: searchButton.leadingAnchor, constant: -10),
			textField.heightAnchor.constraint(equalToConstant: 48)
		])
		
		collectionViewTopConstraint = collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
		NSLayoutConstraint.activate([
			collectionViewTopConstraint,
			collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
			collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
			collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
		])
		
	}
	
	@objc private func searchButtonTapped() {
		configureConstraints()
		loadModels(textSearch)
		textSearch = ""
		textField.text = ""
	}
	
	private func configureConstraints() {
		if !constraintsAreStable {
			collectionViewTopConstraint.isActive = false
			searchButtonTopConstraint.isActive = false
			textFieldTopConstraint.isActive = false
			
			collectionView.isHidden = false
			
			UIView.animate(withDuration: 0.3) { [weak self] in
				guard let self = self else { return }
				NSLayoutConstraint.activate([
					searchButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
					textField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
					collectionView.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 20),
				
					failureLabel.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 56),
					failureLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
					failureLabel.heightAnchor.constraint(equalToConstant: 19),
					failureLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor)
				])
				view.layoutIfNeeded()
			}
			constraintsAreStable = true
		}
	}
	
	private func loadModels(_ response: String) {
		models = []
		textField.resignFirstResponder()
		failureLabel.isHidden = true
		collectionView.reloadData()
		/// Если прятать activityIndicator под isHidden = true то цвет черным не становится поэтому нужно каждый раз добавлять заново на вью
		/// Походу это говнокод зато работает лол
		/// Если знаете как пофиксить чтобы по человечески с ishidden = true работало то отправьте почтового голубя
		view.addSubview(activityIndicator)
		NetworkManager.loadPhotos(searchResponse: response) { [weak self] result in
			guard let self = self else { return }
			switch result {
				case .success(let photoURLs):
					DispatchQueue.main.async {
						self.models = photoURLs
						debugPrint("Количество загруженных фотографий: \(photoURLs.count)")
						if photoURLs.count == 0 {
							self.failureLabel.isHidden = false
						} else {
							self.collectionView.reloadData()
						}
						self.activityIndicator.removeFromSuperview()
					}
				case .failure(let error):
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
			configureConstraints()
			loadModels(text)
			textField.text = ""
			textSearch = ""
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

