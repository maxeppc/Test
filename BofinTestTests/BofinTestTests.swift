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

	func test_ShopService_doCheckout() {
		let itemsToAdd = [Item.Apple, Item.Apple, Item.Orange, Item.Apple]

		shopService?.addItems(itemsToAdd)

		guard let sut = shopService?.getShoppingValue() else {
			XCTFail("Optional error")
			return
		}

		print(sut)

		XCTAssert(sut == 2.05, "Shopping cart value is wrong")
	}
}
