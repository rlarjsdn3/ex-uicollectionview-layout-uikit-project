//
//  FirstCompositionalViewController.swift
//  CompositionalLayoutEx
//
//  Created by 김건우 on 11/9/23.
//

import UIKit

class FirstCompositionalViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var numberData: NumberData = NumberData()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureLayout()
        
        prepareDatasource()
        prepareSnapshot()
    }
    
    func configureLayout() {
        collectionView.collectionViewLayout = createComositionalLayout()
    }
    
    func createComositionalLayout() -> UICollectionViewCompositionalLayout {
        // ⭐️ 아이템의 사이즈는 컨테이너 뷰(그룹)의 너비 33%, 높이 100%로 맞춤.
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(0.33),
            heightDimension: .fractionalHeight(1.0)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        // ⭐️ 그룹의 사이즈는 컨테이너 뷰(섹션)의 너비 100%, 높이 33%로 맞춤.
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalWidth(0.33)
        )
        // ⭐️ 아이템 3개로 구성된 그룹 만듦.
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, repeatingSubitem: item, count: 3)
        group.interItemSpacing = .flexible(5.0) // 아이템 사이 간격이 5.0보다 같거나 더 크게 함.
        
        // ⭐️ 그룹으로 섹션 만듦.
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10)
        section.interGroupSpacing = 5.0
        
        // ⭐️ 이렇게 구성된 아이템, 그룹과 섹션으로 CompositionalLayout 만듦.
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
    
    func prepareDatasource() {
        numberData.dataSource = UICollectionViewDiffableDataSource<NumberSections, NumbersData.ID>(collectionView: collectionView) { collectionView, indexPath, itemID in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "firstCell", for: indexPath) as! FirstCompCell
            
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
