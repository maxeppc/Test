//
//  Promotions.swift
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
