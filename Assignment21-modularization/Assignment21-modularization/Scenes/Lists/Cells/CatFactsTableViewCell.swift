
import UIKit

final class CatFactsTableViewCell: UITableViewCell {

    //MARK: - Properties
    private let mainStackView = UIStackView()
    
    private let factTextView = UILabel()
    
    //MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        addSubViews()
        setupConstraints()
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Prepare for Reuse
    override func prepareForReuse() {
        super.prepareForReuse()
        factTextView.text = nil
    }
    
    //MARK: - Methods
    private func addSubViews() {
        self.addSubview(mainStackView)
        mainStackView.addArrangedSubview(factTextView)
    }
    
    private func setupConstraints() {
        setupMainStackViewConstraints()
        setupMovieNameTextViewConstraints()
    }
    
    private func setupUI() {
        setupMainStackViewUI()
        setupMovieNameTextViewUI()
    }
    
    func configureCell(with catFact: CatFactsModel.Fact) {
        factTextView.text = catFact.fact
    }
    
    //MARK: - UI
    private func setupMainStackViewUI() {
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        mainStackView.isLayoutMarginsRelativeArrangement = true
        mainStackView.axis = .horizontal
        mainStackView.spacing = 5
        mainStackView.alignment = .center
    }
    
    private func setupMovieNameTextViewUI() {
        factTextView.translatesAutoresizingMaskIntoConstraints = false
        factTextView.font = UIFont.systemFont(ofSize: 20)
        factTextView.textAlignment = .left
        factTextView.textColor = .black
        factTextView.numberOfLines = 0
        factTextView.lineBreakMode = .byWordWrapping
    }
    
    //MARK: - Constraints
    private func setupMainStackViewConstraints() {
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            mainStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            mainStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            mainStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
        ])
    }
    
    private func setupMovieNameTextViewConstraints() {
        NSLayoutConstraint.activate([
            factTextView.heightAnchor.constraint(equalTo: mainStackView.heightAnchor)
        ])
    }
    
}
