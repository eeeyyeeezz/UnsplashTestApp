//
//  JsonModel.swift
//  UnsplashTestApp
//
//  Created by Даниил Назаров on 20.06.2023.
//

import Foundation

struct UnsplashResponse: Decodable {
	let results: [UnsplashPhoto]
}

struct UnsplashPhoto: Decodable {
	let urls: UnsplashPhotoURLs
}

struct UnsplashPhotoURLs: Decodable {
	let regular: URL
}
