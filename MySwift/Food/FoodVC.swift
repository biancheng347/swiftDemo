
import UIKit

class FoodVC: UIViewController {
    fileprivate lazy var foodView = lazyFoodView()

    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
}

fileprivate extension FoodVC {
    func setUp() {
        foodView.isHidden = false 
    }
}

fileprivate extension FoodVC {
    func lazyFoodView() -> FoodView {
        return FoodView().then {
            $0.backgroundColor = .clear
        }.make(view) {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
}
