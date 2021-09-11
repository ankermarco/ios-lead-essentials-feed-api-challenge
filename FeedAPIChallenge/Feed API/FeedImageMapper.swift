//
//  FeedImageMapper.swift
//  FeedAPIChallenge
//
//  Created by Ke Ma on 11/09/2021.
//  Copyright © 2021 Essential Developer Ltd. All rights reserved.
//

import Foundation

internal struct FeedImageMapper {
	private struct Root: Decodable {
		let items: [Item]

		var imageItems: [FeedImage] {
			items.map { $0.feedImage }
		}
	}

	private struct Item: Decodable {
		let image_id: UUID
		let image_desc: String?
		let image_loc: String?
		let image_url: URL

		var feedImage: FeedImage {
			FeedImage(id: image_id,
			          description: image_desc,
			          location: image_loc,
			          url: image_url)
		}
	}

	static func map(data: Data, response: HTTPURLResponse) -> FeedLoader.Result {
		guard response.statusCode == 200,
		      let root = try? JSONDecoder().decode(Root.self, from: data) else {
			return .failure(RemoteFeedLoader.Error.invalidData)
		}
		return .success(root.imageItems)
	}
}
