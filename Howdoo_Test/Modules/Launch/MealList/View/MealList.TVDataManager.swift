import UIKit

extension MealList {
    final class TableViewDataManager: NSObject {
        fileprivate let presenter: MealListPresenterProtocol
        
        init(presenter: MealListPresenterProtocol) {
            self.presenter = presenter
        }
    }
}

// MARK: open static logic
extension MealList.TableViewDataManager {
    static func registerClases(for tableView: UITableView) {
        tableView.register(MealList.BaseTVCell.self)
    }
    
    static func configure(_ tableView: UITableView) {
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        tableView.rowHeight = 189
        tableView.estimatedRowHeight = 189
        tableView.sectionHeaderHeight = 10
        tableView.estimatedSectionHeaderHeight = 10
    }
}

// MARK: - UITableViewDelegate & UITableViewDataSource
extension MealList.TableViewDataManager: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return presenter.numberOfItemsToShow()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath) as MealList.BaseTVCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let cell = cell as? VMConfigurableView, let item = presenter.item(at: indexPath.section) {
            let vm = MealList.BaseTVCellVM(meal: item)
            cell.configure(viewModel: vm)
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.didSelectItem(at: indexPath.section)
    }
}
