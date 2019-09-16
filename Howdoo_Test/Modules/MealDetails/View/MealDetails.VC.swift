import UIKit
import TinyConstraints

private typealias ViewController = MealDetails.ViewController

// MARK: - MealDetails.ViewController
extension MealDetails {
    final class ViewController: BaseVC {
        private var restaurantTitleLabel: UILabel!
        
        var presenter: MealDetailsPresenterProtocol?
        
        override func viewDidLoad() {
            super.viewDidLoad()
            presenter?.viewDidLoad()
        }
    }
}

private extension ViewController {
    @objc func doneTapped() {
        presenter?.doneTapped()
    }
}

// MARK: - MealDetailsViewProtocol
extension ViewController: MealDetailsViewProtocol {
    func setupRestaurantTitle(_ title: String) {
        restaurantTitleLabel.text = title
    }
}

// MARK: - LoadViews
extension ViewController {
    override func loadStaticNavigationBar() {
        super.loadStaticNavigationBar()
        navigationController?.navigationBar.barTintColor = .appGrey221
        navigationController?.navigationBar.tintColor = .appBlack41
        
        let titleLabel = UILabel()
        titleLabel.text = "Detail screen"
        titleLabel.font = UIFont.appHNRegular.withSize(18)
        titleLabel.textColor = .appBlack41
        navigationItem.titleView = titleLabel
        
        let doneBtn = UIButton(type: .custom)
        doneBtn.setTitle("Done", for: .normal)
        doneBtn.titleLabel?.font = UIFont.appHNRegular.withSize(16)
        doneBtn.setTitleColor(.appBlack41, for: .normal) 
        doneBtn.addTarget(self, action: #selector(doneTapped), for: .touchUpInside)
        navigationItem.rightBarButtonItem = .init(customView: doneBtn)
    }
    
    override func loadStaticViews() {
        super.loadStaticViews()
        
        restaurantTitleLabel = UILabel()
        restaurantTitleLabel.font = UIFont.appHNRegular.withSize(16)
        restaurantTitleLabel.textColor = .appBlack41
        view.addSubview(restaurantTitleLabel)
        restaurantTitleLabel.centerXToSuperview()
        restaurantTitleLabel.topToSuperview(offset: 29, usingSafeArea: true)
        restaurantTitleLabel.widthToSuperview(offset: -20, relation: .equalOrLess)
    }
}
