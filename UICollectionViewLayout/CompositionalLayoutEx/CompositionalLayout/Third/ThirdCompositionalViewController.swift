//
//  ThirdCompositionalViewController.swift
//  CompositionalLayoutEx
//
//  Created by 김건우 on 11/9/23.
//

import UIKit

class ThirdCompositionalViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var numberData: NumberData = NumberData()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureLayout()
        prepareDatasource()
        prepareSnapshot()
    }
    
    func configureLayout() {
        collectionView.collectionViewLayout = createTwoRowsNestedGroupLayout()
    }
    
    func createTwoRowsNestedGroupLayout() -> UICollectionViewCompositionalLayout {
        // For Item
        let smallItemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(0.5)
        )
        let smallItem = NSCollectionLayoutItem(layoutSize: smallItemSize)
        
        let bigItemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(0.7),
            heightDimension: .fractionalHeight(1.0)
        )
        let bigItem = NSCollectionLayoutItem(layoutSize: bigItemSize)
        
        // For Group
        let innerNestedGroupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(0.3),
            heightDimension: .fractionalHeight(1.0)
        )
        let innerNestedGroup = NSCollectionLayoutGroup.vertical(
            layoutSize: innerNestedGroupSize,
            repeatingSubitem: smallItem,
            count: 2
        )
        innerNestedGroup.interItemSpacing = .fixed(5.0)
        
        let topNestedGroupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(0.5)
        )
        let topNestedGroup = NSCollectionLayoutGroup.horizontal(
            layoutSize: topNestedGroupSize,
            subitems: [bigItem, innerNestedGroup]
        )
        topNestedGroup.interItemSpacing = .flexible(5.0)
        
        let bottomNestedGroup = NSCollectionLayoutGroup.horizontal(
            layoutSize: topNestedGroupSize,
            subitems: [innerNestedGroup, bigItem]
        )
        bottomNestedGroup.interItemSpacing = .flexible(5.0)
        
        let nestedGroupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(0.3)
        )
        let nestedGroup = NSCollectionLayoutGroup.vertical(
            layoutSize: nestedGroupSize,
            subitems: [topNestedGroup, bottomNestedGroup]
        )
        nestedGroup.interItemSpacing = .fixed(5.0)
        
        let section = NSCollectionLayoutSection(group: nestedGroup)
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 5)
        section.interGroupSpacing = 5.0
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
    
    func prepareDatasource() {
        numberData.dataSource = UICollectionViewDiffableDataSource<NumberSections, NumbersData.ID>(collectionView: collectionView) { collectionView, indexPath, itemID in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ThirdCell", for: indexPath) as! ThirdCompCell
            
            if let item = self.numberData.items.first(where: { $0.id == itemID }) {
                cell.title.text = "\(item.number)"
            }
            return cell
        }
    }
    
    func prepareSnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<NumberSections, NumbersData.ID>()
        snapshot.appendSections([.main])
        snapshot.appendItems(numberData.items.map { $0.id })
        numberData.dataSource.apply(snapshot)
    }

}
