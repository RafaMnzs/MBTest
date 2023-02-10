import UIKit

class ListExchangeTableViewCell: UITableViewCell {
    
    private lazy var title: UILabel = {
        let _title = UILabel()
        _title.translatesAutoresizingMaskIntoConstraints = false
        return _title
    }()
    
    private lazy var exchangeId: UILabel = {
        let _exchangeId = UILabel()
        _exchangeId.adjustsFontSizeToFitWidth = true
        _exchangeId.translatesAutoresizingMaskIntoConstraints = false
        return _exchangeId
    }()

    private lazy var volume: UILabel = {
        let _volume = UILabel()
        _volume.adjustsFontSizeToFitWidth = true
        _volume.translatesAutoresizingMaskIntoConstraints = false
        return _volume
    }()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(title)
        contentView.addSubview(volume)
        contentView.addSubview(exchangeId)
        
        
        NSLayoutConstraint.activate([
            title.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            title.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            title.heightAnchor.constraint(equalToConstant: 15.0),
            
            exchangeId.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            exchangeId.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            exchangeId.heightAnchor.constraint(equalToConstant: 15.0),
            
            volume.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            volume.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            volume.heightAnchor.constraint(equalToConstant: 15.0),
        ])
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}


extension ListExchangeTableViewCell {
    
    public func config(exchange: Exchange) {
        title.text = exchange.name
        exchangeId.text = exchange.exchangeID
        
        let formatter = NumberFormatter()
        formatter.currencyCode = "USD"
        formatter.numberStyle = .currency
        if let formattedTipAmount = formatter.string(from: exchange.volume1DayUsd as NSNumber) {
            volume.text = "\(formattedTipAmount)"
        }
    }
}
