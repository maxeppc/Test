//
//  BofinTestTests.swift
//  BofinTestTests
//
//  Created by Michał Gałęziowski on 01/07/2020.
//  Copyright © 2020 Michał Gałęziowski. All rights reserved.
//

import XCTest
@testable import BofinTest

class BofinShopServiceTest: XCTestCase {
	var shopService: ShopService?

	override func setUp() {
		super.setUp()

		shopService = ShopService()
	}

	override func tearDown() {
		super.tearDown()

		shopService = nil
	}

	func test_ShopService_startShopping() {
		shopService?.startShoppings()

		let sut = shopService?.cart

		XCTAssertNotNil(sut, "Cart is nil")
	}

	func test_ShopService_addItems() {
		let itemsToAdd = [Item.Orange, Item.Apple, Item.Orange]

		shopService?.addItems(itemsToAdd)

		guard let sut = shopService?.cart?.items.count else {
			XCTFail("Optional error")
			return
		}

		XCTAssert(sut == itemsToAdd.count, "Items not added correctly to cart")
	}

	func test_ShopService_doCheckout_withoutPromotions() {
		let itemsToAdd = [Item.Apple, Item.Apple, Item.Orange, Item.Apple]

		shopService?.addItems(itemsToAdd)

		guard let sut = shopService?.doCheckout() else {
			XCTFail("Optional error")
			return
		}

		print(sut)

		XCTAssert(sut == 2.05, "Shopping cart value is wrong")
	}

	func test_ShopService_addPromotion() {
		let promotion: Promotion = .OneFreeApple

		shopService?.addPromotion(promotion)

		let sut = shopService?.promotions.last

		XCTAssert(promotion == sut, "Wrong promotion in array")
	}

	func test_Promotion_OneFreeApple() {
		let promotion: Promotion = .OneFreeApple
		let itemsToCart: [Item] = [.Apple]
		let value = 2 * Item.Apple.price
		let cart = ShopCart()

		itemsToCart.forEach { cart.addItem($0) }

		let sut = promotion.calculation(cart: cart)

		XCTAssertEqual(sut.totalValue, value, "Wrong calculation")
	}

	func test_Promotion_ThreeOrangesForTwo() {
		let promotion: Promotion = .ThreeOrangesForTwo
		let itemsToCart: [Item] = Array(repeating: .Orange, count: 13)
		let value = 9 * Item.Orange.price
		let cart = ShopCart()

		itemsToCart.forEach { cart.addItem($0) }

		let sut = promotion.calculation(cart: cart)

		XCTAssertEqual(sut.totalValue, value, "Wrong calculation")
	}

	func test_ShopService_checkoutWithOnePromotion() {
		let itemsToCart: [Item] = [.Apple, .Orange, .Apple]

		shopService?.addPromotion(.OneFreeApple)
		shopService?.addItems(itemsToCart)

		let sut = shopService?.doCheckout()
		let value = 4 * Item.Apple.price + Item.Orange.price

		XCTAssertEqual(sut, value, "Wrong calculation")
	}

	func test_ShopService_checkoutWithTwoPromotions() {
		let itemsToCart: [Item] = [.Apple, .Orange, .Apple, .Orange, .Orange, .Apple, .Orange]

		shopService?.addPromotion(.OneFreeApple)
		shopService?.addPromotion(.ThreeOrangesForTwo)
		shopService?.addItems(itemsToCart)

		let sut = shopService?.doCheckout()
		let value = 6 * Item.Apple.price +  3 * Item.Orange.price

		XCTAssertEqual(sut, value, "Wrong calculation")
	}
}
