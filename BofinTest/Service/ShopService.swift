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
	case ThreeOrangesForTwo

	func calculation(cart: ShopCart) -> ShopCart {
		switch self {
			case .OneFreeApple: return oneFreeApplePromotion(cart: cart)
			case .ThreeOrangesForTwo: return threeOrangesForFreePromotion(cart: cart)
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

	private func threeOrangesForFreePromotion(cart: ShopCart) -> ShopCart {
		let outputCart = cart

		let orangesCount = cart.items.filter { $0 == .Orange }.count

		if orangesCount >= 3 {
			let bonuses = orangesCount / 3
			outputCart.bonus = Double(bonuses) * Item.Orange.price
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
