//
//  BasketViewController.swift
//  ArbuzKZ
//
//  Created by Жансая Шакуали on 16.05.2024.
//

import UIKit
import SwiftUI

class BasketViewController: UIViewController {
    
    enum Section {
        case main
    }
    
    lazy var emptyView: UIHostingController = {
        let controller = UIHostingController(rootView: EmptyBasketView())
        return controller
    }()
    
    lazy var cartButton: UIHostingController = {
        let controller = UIHostingController(rootView: CartButton(cartManager: cartManager))
        return controller
    }()
    
    lazy var collectionView = CollectionView()
    var dataSource: UICollectionViewDiffableDataSource<Section, ProductModel>?
    var items: [ProductModel] {
        cartManager.getProducts()
    }
    
    let cartManager: CartManager
    let favoriteManager: FavoriteProductsManager
    
    init(cartManager: CartManager, favoriteManager: FavoriteProductsManager) {
        self.cartManager = cartManager
        self.favoriteManager = favoriteManager
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLayout()
        configureDataSource()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        applySnapshot()
    }
    
    private func setLayout() {
        view.backgroundColor = .white
        addCartButton()
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: cartButton.view.topAnchor)
        ])
        collectionView.rootVC = self
        collectionView.register(
            HostingCollectionViewCell.self,
            forCellWithReuseIdentifier: "Cell"
        )
    }
    
    func addCartButton() {
        addChild(cartButton)
        cartButton.view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(cartButton.view)
        NSLayoutConstraint.activate([
            cartButton.view.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            cartButton.view.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            cartButton.view.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            cartButton.view.heightAnchor.constraint(equalToConstant: 60)
        ])
        cartButton.didMove(toParent: self)
    }
    
    private func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource(
            collectionView: collectionView
        ) { [weak self] collectionView, indexPath, itemIdentifier in
            guard let self, let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as? HostingCollectionViewCell else { return UICollectionViewCell() }
            
            cell.embed(
                in: self,
                withContent: self.items[indexPath.row],
                cartManager: cartManager,
                favoriteManager: favoriteManager,
                onClose: {
                    if let indexPath = self.collectionView.indexPath(for: cell) {
                        self.removeProduct(self.items[indexPath.row])
                    }
                },
                onFavorite: { id in
                    if let indexPath = self.collectionView.indexPath(for: cell) {
                        
                    }
                },
                onTap: {
                    if let indexPath = self.collectionView.indexPath(for: cell) {
                        self.showProductDetailView(self.items[indexPath.row])
                    }
                },
                onUpdate: {
                    self.applySnapshot()
                }
            )
            
            return cell
        }
        
        applySnapshot()
    }
    
    private func applySnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, ProductModel>()
        snapshot.appendSections([.main])
        snapshot.appendItems(items)
        dataSource?.apply(snapshot)
        addEmptyViewIfNeeded()
    }
    
    private func removeProduct(_ product: ProductModel) {
        cartManager.removeProduct(product)
        applySnapshot()
    }
    
    private func changeIsFavoriteState(for id: Int) {
        // Add to/Remove from favorites
    }
    
    private func addEmptyViewIfNeeded() {
        if items.isEmpty {
            addChild(emptyView)
            emptyView.view.frame = view.bounds
            view.addSubview(emptyView.view)
            emptyView.didMove(toParent: self)
        } else {
            emptyView.willMove(toParent: nil)
            emptyView.view.removeFromSuperview()
            emptyView.removeFromParent()
        }
    }
    
    private func showProductDetailView(_ product: ProductModel) {
        let vc = UIHostingController(
            rootView: ProductDetailView(
                product: product,
                onClose: {
                    self.presentedViewController?.dismiss(animated: true)
                }
            )
        )
        
        present(vc, animated: true)
    }
}

class CollectionView: UICollectionView {
    
    weak var rootVC: UIViewController!
    private let columnCount: Int = 1
    
    override init(frame: CGRect = .zero, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: UICollectionViewLayout())
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    func commonInit(){
        setCollectionViewLayout(UICollectionViewCompositionalLayout(sectionProvider: layout), animated: false)
    }
    
    private func layout(for sectionIndex: Int, environment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? {
        return .gridSection(columnCount: columnCount)
    }
}

extension NSCollectionLayoutSection {
    
    static func gridSection(columnCount: Int, showBadgeViews: Bool = false) -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(120))
        let item = NSCollectionLayoutItem(layoutSize: itemSize, supplementaryItems: [])
        
        item.contentInsets = .init(top: 5, leading: 5, bottom: 5, trailing: 5)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(120))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        return section
    }
}

extension UIView {
    
    func edgesToSuperview() {
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: superview!.topAnchor),
            bottomAnchor.constraint(equalTo: superview!.bottomAnchor),
            leadingAnchor.constraint(equalTo: superview!.leadingAnchor),
            trailingAnchor.constraint(equalTo: superview!.trailingAnchor)
        ])
    }
}
