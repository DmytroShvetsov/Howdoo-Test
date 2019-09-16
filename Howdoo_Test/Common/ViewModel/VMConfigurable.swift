import UIKit

// MARK: - VMConfigurable
typealias VMConfigurableView = UIView & VMConfigurable

protocol VMConfigurable {
    func configure(viewModel: ViewModel)
}

// MARK: - CustomVMConfigurable
typealias CustomVMConfigurableView = UIView & CustomVMConfigurable

protocol CustomVMConfigurable: VMConfigurable {
    associatedtype CustomVM: ViewModelProtocol
    func configure(viewModel: CustomVM)
}

extension CustomVMConfigurable where CustomVM: ViewModel {
    func configure(viewModel: ViewModel) {
        guard let viewModel = viewModel as? CustomVM else { return }
        configure(viewModel: viewModel)
    }
}
