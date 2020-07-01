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
	private(set) var promotions: [Promotion] = []

	func startShoppings() {
		cart = ShopCart()
	}

	func addItems(_ items: [Item]) {
		if cart == nil {
			cart = ShopCart()
		}

		items.forEach { cart?.addItem($0) }
	}

	func doCheckout() -> Double {
		var outputCart = cart

		promotions.forEach {
			if let cart = cart {
				outputCart = $0.calculation(cart: cart)
			}
		}

		return outputCart?.totalValue ?? 0.0
	}

	func addPromotion(_ promotion: Promotion) {
		if !promotions.contains(promotion) {
			promotions.append(promotion)
		}
	}
}
