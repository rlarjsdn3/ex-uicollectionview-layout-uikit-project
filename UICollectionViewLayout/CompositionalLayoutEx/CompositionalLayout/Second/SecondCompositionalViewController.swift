//
//  SecondCompositionalViewController.swift
//  CompositionalLayoutEx
//
//  Created by 김건우 on 11/9/23.
//

import UIKit

class SecondCompositionalViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!

    var numberData: NumberData = NumberData()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureLayout()
        prepareDatasource()
        prepareSnapshot()
    }
    
    func configureLayout() {
        collectionView.collectionViewLayout = createOneRowNestedGroupLayout()
    }
    
    func createOneRowNestedGroupLayout() -> UICollectionViewCompositionalLayout {
        let leadingItemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(0.7),
            heightDimension: .fractionalHeight(1.0)
        )
        let leadingItem = NSCollectionLayoutItem(layoutSize: leadingItemSize)
//        leadingItem.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
        
        let trailingItemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(0.5)
        )
        let trailingItem = NSCollectionLayoutItem(layoutSize: trailingItemSize)
//        trailingItem.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
        
        let trailingGroupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(0.3),
            heightDimension: .fractionalHeight(1.0)
        )
        let trailingGroup = NSCollectionLayoutGroup.vertical(
            layoutSize: trailingGroupSize,
            repeatingSubitem: trailingItem,
            count: 2
        )
        trailingGroup.interItemSpacing = .flexible(5.0)
        
        let nestedGroupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(0.3)
        )
        let nestedGroup = NSCollectionLayoutGroup.horizontal(
            layoutSize: nestedGroupSize,
            subitems: [leadingItem, trailingGroup]
        )
        nestedGroup.interItemSpacing = .flexible(5.0)
        
        let section = NSCollectionLayoutSection(group: nestedGroup)
        section.interGroupSpacing = 5.0
        section.contentInsets = NSDirectionalEdgeInsets(top: 0.0, leading: 5.0, bottom: 0.0, trailing: 5.0)
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
    
    func prepareDatasource() {
        numberData.dataSource = UICollectionViewDiffableDataSource<NumberSections, NumbersData.ID>(collectionView: collectionView) { collectionView, indexPath, itemID in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "secondCell", for: indexPath) as! SecondCompCell
            
            if let item = self.numberData.items.first(where: { $0.id == itemID }) {
                cell.title.text = "\(item.number)"
                cell.contentView.backgroundColor = UIColor.systemMint
                cell.contentView.clipsToBounds = true
                cell.contentView.layer.cornerRadius = 10.0
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
