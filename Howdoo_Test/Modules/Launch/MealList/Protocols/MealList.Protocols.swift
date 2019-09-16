import Foundation

protocol MealListViewProtocol: class {
    func loaderView(show: Bool)
    func reloadData()
}

protocol MealListPresenterProtocol {
    func viewDidLoad()
    func viewWillAppear()
    func pullToRefreshTriggered()
    func didSelectItem(at index: Int)

    // Data Source
    func numberOfItemsToShow() -> Int
    func item(at index: Int) -> Meal?
}

protocol MealListRouterProtocol {
    func showMealDetails(_ meal: Meal)
    func showError(_ error: Error)
}

// MARK: - Namespace
enum MealList {
    enum Models {}
}
