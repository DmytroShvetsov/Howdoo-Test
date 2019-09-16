import Foundation

private typealias Presenter = MealList.Presenter

// MARK: - MealList.Presenter
extension MealList {
    final class Presenter: NSObject {
        weak var view: MealListViewProtocol?
        var router:    MealListRouterProtocol?

        private let workflow: MealList.Workflow
        private var meals: [Meal] = []
        private var isLoadingMeals = false
        
        init(workflow: MealList.Workflow) {
            self.workflow = workflow
            super.init()
        }
    }
}

// MARK: - private logic
private extension Presenter {
    func loadMeals() {
        guard !isLoadingMeals else { return }
        isLoadingMeals = true
        Network.MealProvider.meals { [weak self] result in
            switch result {
                case .success(let response):
                    self?.meals = response
                case .failure(let error):
                    self?.router?.showError(error)
            }
            self?.didLoadMeals()
        }
    }
    
    func didLoadMeals() {
        view?.reloadData()
        view?.loaderView(show: false)
        isLoadingMeals = false
    }
}

// MARK: - MealListPresenterProtocol
extension Presenter: MealListPresenterProtocol {
    func viewDidLoad() {
        view?.loaderView(show: true)
        loadMeals()
    }

    func viewWillAppear() {
        view?.reloadData()
    }
    
    func pullToRefreshTriggered() {
        loadMeals()
    }
    
    func didSelectItem(at index: Int) {
        guard index < meals.count else { return }
        router?.showMealDetails(meals[index])
    }

    func numberOfItemsToShow() -> Int {
        return meals.count
    }

    func item(at index: Int) -> Meal? {
        guard index < meals.count else { return nil }
        return meals[index]
    }
}
