//
//  TextField.swift
//  UnsplashTestApp
//
//  Created by Даниил Назаров on 20.06.2023.
//

import UIKit

final class MessageTextField: UITextField {
	
//	private let textPadding = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)

	private let magnifyingGlassImage: UIImageView = {
		let imageView = UIImageView()
		imageView.tintColor = #colorLiteral(red: 0.7686274648, green: 0.7686274648, blue: 0.7686274648, alpha: 1)
		let magnifyingGlassImage = UIImage(systemName: "magnifyingglass")
		imageView.image = magnifyingGlassImage
		imageView.frame = CGRect(x: 0, y: 5, width: 45, height: 20)
		imageView.contentMode = .scaleAspectFit
		return imageView
	}()
	
	init() {
		super.init(frame: .zero)
		setupTextField(placeholder: "Телефоны, яблоки, груши")
	}
	
//	override func textRect(forBounds bounds: CGRect) -> CGRect {
//		let rect = super.textRect(forBounds: bounds)
//		return rect.inset(by: textPadding)
//	}
//
//	override func editingRect(forBounds bounds: CGRect) -> CGRect {
//		let rect = super.editingRect(forBounds: bounds)
//		return rect.inset(by: textPadding)
//	}
	
	private func setupTextField(placeholder: String) {
		translatesAutoresizingMaskIntoConstraints = false
		textColor = #colorLiteral(red: 0.611764729, green: 0.6117646694, blue: 0.611764729, alpha: 1)
		layer.cornerRadius = 10
		layer.backgroundColor = #colorLiteral(red: 0.9333333373, green: 0.9333333373, blue: 0.9333333373, alpha: 1)
		attributedPlaceholder = NSAttributedString(string: placeholder,
														   attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
		
		leftViewMode = .always
		leftView = magnifyingGlassImage
		clearButtonMode = .whileEditing
		returnKeyType = UIReturnKeyType.search
	}
	
	@available(*, unavailable)
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
