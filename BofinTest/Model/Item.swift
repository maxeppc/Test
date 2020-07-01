//
//  Item.swift
//  BofinTest
//
//  Created by Michał Gałęziowski on 01/07/2020.
//  Copyright © 2020 Michał Gałęziowski. All rights reserved.
//

import Foundation

enum Item {
	case Orange
	case Apple

	var price: Double {
		switch self {
		case .Orange: return 0.25
		case .Apple: return 0.6
		}
	}
}
