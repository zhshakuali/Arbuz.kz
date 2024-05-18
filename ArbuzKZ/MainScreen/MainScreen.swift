//
//  MainScreen.swift
//  ArbuzKZ
//
//  Created by Жансая Шакуали on 18.05.2024.
//

import SwiftUI

class MainScreenViewController: UIViewController {
    
    lazy var mainScreen: UIHostingController = {
        let controller = UIHostingController(
            rootView: MainScreen(
                cartManager: cartManager,
                favoriteManager: favoriteManager
            ) { product in
                self.showProductDetailScreen(product)
            }
        )
        
        return controller
    }()
    
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
        addMainScreen()
    }
    
    func addMainScreen() {
        addChild(mainScreen)
        mainScreen.view.frame = view.bounds
        view.addSubview(mainScreen.view)
        mainScreen.didMove(toParent: self)
    }
    
    func showProductDetailScreen(_ product: ProductModel) {
        let view = UIHostingController(
            rootView: ProductDetailView(
                product: product,
                onClose: {
                    self.presentedViewController?.dismiss(animated: true)
                }
            )
            .environmentObject(cartManager)
            .environmentObject(favoriteManager)
        )
        
        present(view, animated: true)
    }
}

struct MainScreen: View {
    
    let products: [ProductModel] = [
        .mockProduct1, 
        .mockProduct2,
        .mockProduct3,
        .mockProduct4
    ]
    
    @ObservedObject var cartManager: CartManager
    @ObservedObject var favoriteManager: FavoriteProductsManager
    
    let onTapProduct: (ProductModel) -> Void
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.flexible(), alignment: .top), GridItem(.flexible(), alignment: .top)], content: {
                ForEach(products) { product in
                    CellView(cartManager: cartManager, favoriteManager: favoriteManager, product: product)
                        .onTapGesture {
                            onTapProduct(product)
                        }
                }
            })
            .padding(.horizontal, 12)
        }
    }
}

#Preview {
    MainScreen(cartManager: CartManager(), favoriteManager: FavoriteProductsManager()) { _ in
        
    }
}
