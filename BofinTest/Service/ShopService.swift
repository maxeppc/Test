//
//  ShopService.swift
//  BofinTest
//
//  Created by Michał Gałęziowski on 01/07/2020.
//  Copyright © 2020 Michał Gałęziowski. All rights reserved.
//

import Foundation

enum Promotion {
	case OneFreeApple

	func calculation(cart: ShopCart) -> ShopCart {
		switch self {
			case .OneFreeApple:
				return oneFreeApplePromotion(cart: cart)
		}
	}

	private func oneFreeApplePromotion(cart: ShopCart) -> ShopCart {
		let outputCart = cart

		cart.items.forEach {
			if $0 == .Apple {
				outputCart.addItem(.Apple)
			}
		}

		return outputCart
	}
}

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

		promotions.forEach {
			if let cart = cart {
				self.cart = $0.calculation(cart: cart)
			}
		}
	}

	func getShoppingValue() -> Double {
		return cart?.totalValue ?? 0.0
	}

	func addPromotion(_ promotion: Promotion) {
		if !promotions.contains(promotion) {
			promotions.append(promotion)
		}
	}
}
