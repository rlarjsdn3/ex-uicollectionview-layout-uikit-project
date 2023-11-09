//
//  NumberData.swift
//  CompositionalLayoutEx
//
//  Created by 김건우 on 11/10/23.
//

import UIKit

enum NumberSections {
    case main
}

class NumbersData: Identifiable {
    var id: UUID = UUID()
    var number: Int
    
    init(_ number: Int) {
        self.number = number
    }
}

struct NumberData {
    var dataSource: UICollectionViewDiffableDataSource<NumberSections, NumbersData.ID>!
    
    var items: [NumbersData] = []
    
    init() {
        (1..<100).forEach {
            items.append(NumbersData($0))
        }
    }
}
