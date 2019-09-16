import UIKit
import TinyConstraints

private typealias ViewController = MealList.ViewController

// MARK: - MealList.ViewController
extension MealList {
    final class ViewController: BaseVC {
        private var tableView: UITableView!
        private var tableViewDataManager: TableViewDataManager?
        private var refreshControl: UIRefreshControl!
        
        var presenter: MealListPresenterProtocol?

        override func viewDidLoad() {
            super.viewDidLoad()

            if let presenter = presenter {
                tableViewDataManager = TableViewDataManager(presenter: presenter)
                tableView.delegate   = tableViewDataManager
                tableView.dataSource = tableViewDataManager
            }

            presenter?.viewDidLoad()
        }

        override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            presenter?.viewWillAppear()
        }
    }
}

private extension ViewController {
    @objc func refreshControlTriggered() {
        presenter?.pullToRefreshTriggered()
    }
}

// MARK: - MealListViewProtocol
extension ViewController: MealListViewProtocol {
    func loaderView(show: Bool) {
        if show {
            view.showLoader()
        } else {
            if refreshControl.isRefreshing {
                refreshControl.endRefreshing()
            }
            view.removeLoader()
        }
    }
    
    func reloadData() {
        tableView.reloadData()
    }
}

// MARK: - LoadViews
extension ViewController {
    override func loadStaticNavigationBar() {
        super.loadStaticNavigationBar()
        navigationController?.navigationBar.isHidden = true
    }
    
    override func loadStaticViews() {
        super.loadStaticViews()

        view.backgroundColor = .appGrey221
        
        tableView = UITableView()
        tableView.contentInset.bottom = 10
        MealList.TableViewDataManager.configure(tableView)
        MealList.TableViewDataManager.registerClases(for: tableView)
        view.addSubview(tableView)
        tableView.edges(to: view)

        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshControlTriggered), for: .valueChanged)
        if #available(iOS 10.0, *) {
            tableView.refreshControl = refreshControl
        } else {
            tableView.backgroundView = refreshControl
        }
    }
}
