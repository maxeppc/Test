//
//  ShopService.swift
//  BofinTest
//
//  Created by Michał Gałęziowski on 01/07/2020.
//  Copyright © 2020 Michał Gałęziowski. All rights reserved.
//

import Foundation

class ShopService {
	private(set) var cart: ShopCart?

	func startShoppings() {
		cart = ShopCart()
	}

	func addItems(_ items: [Item]) {
		if cart == nil {
			cart = ShopCart()
		}

		items.forEach { cart?.addItem($0) }
	}

	func getShoppingValue() -> Double {
		return cart?.totalValue ?? 0.0
	}
}
