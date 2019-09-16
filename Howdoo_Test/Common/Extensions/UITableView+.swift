import UIKit

// MARK: - register cell & dequeueReusableCell
extension UITableView {
    func register<T>(_ cellClass: T.Type, isNib: Bool = false, forCellWithReuseIdentifier identifier: String = T.identifier) where T: UITableViewCell {
        if isNib {
            register(UINib(nibName: String(describing: T.classForCoder()), bundle: nil), forCellReuseIdentifier: identifier)
        } else {
            register(T.classForCoder(), forCellReuseIdentifier: identifier)
        }
    }
    
    func dequeueReusableCell<T>(withReuseIdentifier identifier: String = T.identifier, for indexPath: IndexPath) -> T where T: UITableViewCell {
        guard let cell = dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? T else {
            assertionFailure("Cell \(T.classForCoder()) not registered in tableView")
            return T()
        }
        return cell
    }
}
