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
		let items: [FeedImage]
	}
	
	static func map(data: Data, response: HTTPURLResponse) -> FeedLoader.Result {
		guard response.statusCode == 200,
			  let root = try? JSONDecoder().decode(Root.self, from: data) else {
			return .failure(RemoteFeedLoader.Error.invalidData)
		}
		return .success(root.items)
	}
}
