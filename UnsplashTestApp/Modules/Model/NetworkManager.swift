//
//  NetworkManager.swift
//  UnsplashTestApp
//
//  Created by Даниил Назаров on 21.06.2023.
//

import Foundation

final class NetworkManager {
	
	private static var paginationCounter = 1
	
	static func loadPhotos(searchResponse: String, completion: @escaping (Result<[URL], Error>) -> Void) {
		let response = searchResponse.replacingOccurrences(of: " ", with: "&")
		
		let urlString = "https://api.unsplash.com/search/photos?client_id=Ip0XA55zY7b7-d19osq1L5btGg-YCeDZVpnnJjXqHxs&query=\(response)&page=\(paginationCounter)"

		guard let url = URL(string: urlString) else {
			completion(.failure(NSError(domain: "Invalid URL", code: -1, userInfo: nil)))
			return
		}

		let task = URLSession.shared.dataTask(with: url) { (data, _, error) in
			if let error = error {
				completion(.failure(error))
				return
			}

			guard let data = data else {
				completion(.failure(NSError(domain: "No data received", code: -1, userInfo: nil)))
				return
			}

			do {
				let response = try JSONDecoder().decode(UnsplashResponse.self, from: data)
				let photoURLs = response.results.map { $0.urls.regular }
				paginationCounter += 1
				completion(.success(photoURLs))
			} catch {
				completion(.failure(error))
			}
		}

		task.resume()
	}
	
	static func parseAndLoadImage(fromURL url: URL, completion: @escaping (Result<Data, Error>) -> Void) {
		let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
			if let error = error {
				completion(.failure(error))
				return
			}
			
			guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
				let error = NSError(domain: "APIError", code: 0, userInfo: nil)
				completion(.failure(error))
				return
			}
			
			guard let data = data else {
				let error = NSError(domain: "APIError", code: 0, userInfo: nil)
				completion(.failure(error))
				return
			}
			completion(.success(data))
		}

		task.resume()
	}


	
}
