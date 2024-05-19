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
    
    @State var headerHeight: CGFloat = 128
    
    @ObservedObject var cartManager: CartManager
    @ObservedObject var favoriteManager: FavoriteProductsManager
    
    let onTapProduct: (ProductModel) -> Void
    
    var body: some View {
        VStack(spacing: 20) {
            Color.clear
                .frame(height: max(headerHeight, 0), alignment: .top)
                .background(
                    CellView(
                        cartManager: cartManager,
                        favoriteManager: favoriteManager,
                        product: .mockProduct1,
                        type: .wide
                    )
                    .frame(height: 128, alignment: .top)
                    .padding(.horizontal, 14)
                )
                .clipped()
            
            ScrollView {
                offsetReader
                VStack(spacing: 20) {
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        LazyHGrid(rows: [GridItem(.flexible(), spacing: 20)],
                                  content: {
                            ForEach(products) { product in
                                CellView(
                                    cartManager: cartManager,
                                    favoriteManager: favoriteManager,
                                    product: product,
                                    type: .wide
                                )
                                .frame(height: 96)
                                .onTapGesture {
                                    onTapProduct(product)
                                }
                            }
                        })
                    }
                    
                    LazyVGrid(columns: [GridItem(.flexible(), alignment: .top), GridItem(.flexible(), alignment: .top)], content: {
                        ForEach(products) { product in
                            CellView(cartManager: cartManager, favoriteManager: favoriteManager, product: product)
                                .onTapGesture {
                                    onTapProduct(product)
                                }
                        }
                    })
                }
                .padding(.horizontal, 12)
                .padding(.top, -8)
            }
            .background(Color.white)
            .coordinateSpace(name: "frameLayer")
            .onPreferenceChange(OffsetPreferenceKey.self) { offset in
                if offset.y < 0 && headerHeight >= 0 {
                    headerHeight += offset.y
                } else if headerHeight <= 128 && offset.y >= 0 {
                    headerHeight += min(offset.y, 128)
                }
            }
        }
    }
    
    var offsetReader: some View {
        GeometryReader { proxy in
            Color.clear
                .preference(
                    key: OffsetPreferenceKey.self,
                    value: proxy.frame(in: .named("frameLayer")).origin
                )
        }
        .frame(height: 0)
    }
}

struct OffsetPreferenceKey: PreferenceKey {
    public static var defaultValue: CGPoint = .zero
    
    public static func reduce(value: inout CGPoint, nextValue: () -> CGPoint) {
        guard nextValue().y > 0 else { return }
        
        value = nextValue()
    }
}

#Preview {
    MainScreen(cartManager: CartManager(), favoriteManager: FavoriteProductsManager()) { _ in
        
    }
}
