//
//  Extension.swift
//  RGToolKit
//
//  Created by Ritesh Gupta on 26/11/16.
//  Copyright © 2016 Ritesh Gupta. All rights reserved.
//

import Foundation
import UIKit

public extension Collection where Iterator.Element == String {
	
	public func combineSeparatedBy(_ character: String) -> String {
		let combiner: (String, String) -> String = {
			$0 + $1 + character
		}
		var combined = reduce("", combiner)
		combined.remove(at: combined.endIndex)
		return combined
	}
}

public extension Collection where Iterator.Element: Equatable {
	
	public func after(_ element: Iterator.Element) -> Iterator.Element? {
		guard let idx = index(of: element), index(after: idx) < endIndex else { return nil }
		let nextIdx = index(after: idx)
		return self[nextIdx]
	}
	
	public func before(_ element: Iterator.Element) -> Iterator.Element? {
		guard let idx = index(of: element), index(before: idx) >= startIndex else { return nil }
		let previousIdx = index(idx, offsetBy: -1)
		return self[previousIdx]
	}
	
	public func index(before idx: Index) -> Index {
		return index(idx, offsetBy: -1)
	}
}

public extension Array  {
	
	public mutating func remove(_ handler: (Iterator.Element) -> Bool) {
		guard let idx = index(where: (handler)) else { return }
		remove(at: idx)
	}
	
	public func removed(_ handler: (Iterator.Element) -> Bool) -> Array {
		guard let idx = index(where: (handler)) else { return self }
		var items = self
		items.remove(at: idx)
		return items
	}
	
	public func appended(_ items: Array) -> Array {
		var newItems = self
		newItems.append(contentsOf: items)
		return newItems
	}
}
