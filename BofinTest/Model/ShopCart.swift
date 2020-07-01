//
//  ShopCart.swift
//  BofinTest
//
//  Created by Michał Gałęziowski on 01/07/2020.
//  Copyright © 2020 Michał Gałęziowski. All rights reserved.
//

import Foundation

class ShopCart {
	private(set) var items: [Item] = []

	var totalValue: Double {
		return items.reduce(0) { $0 + $1.price } - bonus
	}

	var bonus: Double = 0
}

extension ShopCart {
	func addItem(_ item: Item) {
		self.items.append(item)
	}
}
