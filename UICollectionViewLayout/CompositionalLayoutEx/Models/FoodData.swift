//
//  ApplicationData.swift
//  CompositionalLayoutEx
//
//  Created by 김건우 on 11/10/23.
//

import UIKit

enum FoodSections {
    case main
}

class FoodsData: Identifiable {
    var id: UUID = UUID()
    var name: String
    var image: String
    var calories: Int
    var selected: Bool
    
    init(_ name: String, _ image: String, _ calories: Int, _ selected: Bool) {
        self.name = name
        self.image = image
        self.calories = calories
        self.selected = selected
    }
}

struct FoodData {
    var dataSource: UICollectionViewDiffableDataSource<FoodSections, FoodsData.ID>!
    
    var items: [FoodsData] = [] {
        didSet {
            items.sort(by: { $0.name < $1.name })
        }
    }
    
    init() {
        items.append(FoodsData("Bagels", "bagels", 250, false))
        items.append(FoodsData("Brownies", "brownies", 466, false))
        items.append(FoodsData("Butter", "butter", 717, false))
        items.append(FoodsData("Cheese", "cheese", 402, false))
        items.append(FoodsData("Coffee", "coffee", 0, false))
        items.append(FoodsData("Cookies", "cookies", 502, false))
        items.append(FoodsData("Donuts", "donuts", 452, false))
        items.append(FoodsData("Granola", "granola", 471, false))
        items.append(FoodsData("Juice", "juice", 23, false))
        items.append(FoodsData("Lemonade", "lemonade", 40, false))
        items.append(FoodsData("Lettuce", "lettuce", 15, false))
        items.append(FoodsData("Milk", "milk", 42, false))
        items.append(FoodsData("Oatmeal", "oatmeal", 68, false))
        items.append(FoodsData("Potatoes", "potato", 77, false))
        items.append(FoodsData("Tomatoes", "tomato", 18, false))
        items.append(FoodsData("Yogurt", "yogurt", 59, false))
    }
}
