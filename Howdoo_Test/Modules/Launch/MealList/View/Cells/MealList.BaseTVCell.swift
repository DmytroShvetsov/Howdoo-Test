import UIKit
import Kingfisher

// MARK: - MealList.BaseTVCellVM
extension MealList {
    final class BaseTVCellVM: ViewModel {
        fileprivate let caption: String
        fileprivate let title: String
        fileprivate let price: String?
        fileprivate var imageUrl: URL
        
        init(meal: Meal) {
            caption  = meal.restaurantName
            title    = meal.name
            imageUrl = meal.image
            
            let formatter = NumberFormatter()
            formatter.maximumFractionDigits = 2
            formatter.numberStyle = .currency
            formatter.currencySymbol = "$"
            formatter.roundingMode = .down
            price = formatter.string(from: meal.price as NSNumber)
        }
    }
}

// MARK: - MealList.BaseTVCell
extension MealList {
    final class BaseTVCell: UITableViewCell, CustomVMConfigurable {
        private var coverImageView: UIImageView!
        private var coverCaptionLabel: UILabel!
        private var titleLabel: UILabel!
        private var priceLabel: UILabel!
        
        required override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)
            setup()
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        func configure(viewModel: BaseTVCellVM) {
            coverCaptionLabel.text = viewModel.caption
            titleLabel.text = viewModel.title
            priceLabel.text = viewModel.price
            
            coverImageView.kf.cancelDownloadTask()

            let processor = DownsamplingImageProcessor(size: .init(width: UIScreen.main.bounds.size.width, height: 95))
            coverImageView.kf.setImage(
                with: viewModel.imageUrl,
                options: [
                    .processor(processor),
                    .scaleFactor(UIScreen.main.scale),
                    .transition(.fade(1)),
                    .cacheOriginalImage
            ])
        }
    }
}

// MARK: - MealList.BaseTVCell
private extension MealList.BaseTVCell {
    func setup() {
        backgroundColor = .appGrey245
        selectionStyle = .none
        
        let topView = UIView()
        contentView.addSubview(topView)
        topView.edges(to: contentView, excluding: .bottom, insets: .init(top: 10, left: 10, bottom: 0, right: 10))
        
        coverImageView = UIImageView()
        coverImageView.kf.indicatorType = .activity
        coverImageView.contentMode = .scaleAspectFill
        coverImageView.clipsToBounds = true
        topView.addSubview(coverImageView)
        coverImageView.centerXToSuperview()
        coverImageView.widthToSuperview()
        coverImageView.topToSuperview()
        coverImageView.height(95)
        
        let coverImageViewFadeView = UIView()
        coverImageViewFadeView.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        coverImageView.addSubview(coverImageViewFadeView)
        coverImageViewFadeView.edgesToSuperview()
        
        coverCaptionLabel = UILabel()
        coverCaptionLabel.textColor = .white
        coverCaptionLabel.font = UIFont.appHNRegular.withSize(18)
        coverImageView.addSubview(coverCaptionLabel)
        coverCaptionLabel.centerXToSuperview()
        coverCaptionLabel.centerYToSuperview()
        coverCaptionLabel.widthToSuperview(offset: -12, relation: .equalOrLess)
        coverCaptionLabel.heightToSuperview(offset: -12, relation: .equalOrLess)
        
        titleLabel = UILabel()
        titleLabel.font = UIFont.appHNRegular.withSize(16)
        titleLabel.textColor = .appBlack41
        topView.addSubview(titleLabel)
        titleLabel.leftToSuperview()
        titleLabel.topToBottom(of: coverImageView, offset: 15)
        titleLabel.bottomToSuperview(offset: 15)
        
        priceLabel = UILabel()
        priceLabel.font = UIFont.appHNRegular.withSize(16)
        priceLabel.textColor = .appBlack41
        topView.addSubview(priceLabel)
        priceLabel.rightToSuperview()
        priceLabel.centerY(to: titleLabel)
        priceLabel.leftToRight(of: titleLabel, offset: 10, relation: .equalOrGreater)
        
        let bottomView = UIView()
        bottomView.backgroundColor = .appGrey239
        contentView.addSubview(bottomView)
        bottomView.bottomToSuperview()
        bottomView.centerXToSuperview()
        bottomView.widthToSuperview()
        bottomView.height(36)
        
        let detailsLabel = UILabel()
        detailsLabel.text = "See detail"
        detailsLabel.font = UIFont.appHNRegular.withSize(14)
        detailsLabel.textColor = .appBlack41
        bottomView.addSubview(detailsLabel)
        detailsLabel.centerXToSuperview()
        detailsLabel.centerYToSuperview()
    }
}
