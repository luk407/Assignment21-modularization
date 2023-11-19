
import UIKit

final class CatFactsViewController: UIViewController {
    
    //MARK: - Properties
    private let mainStackView = UIStackView()
    
    private let catFactsTableView = UITableView()
    
    private var catFacts = CatFactsModel(data: nil)
    
    private let catFactsViewModel = CatFactsViewModel()
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        addSubViews()
        setupConstraints()
        setupUI()
        registerCatFactsTableViewCell()
        setupCatFactsViewModelDelegate()
        catFactsViewModel.viewDidLoad()
    }
    
    //MARK: Add SubViews, Constraints, UI etc
    private func addSubViews() {
        view.addSubview(mainStackView)
        mainStackView.addArrangedSubview(catFactsTableView)
    }
    
    private func setupConstraints() {
        setupMainStackViewConstraints()
        setupCatFactsTableViewConstraints()
    }
    
    private func setupUI() {
        setupMainStackViewUI()
        setupCatFactsTableViewUI()
    }
    
    private func registerCatFactsTableViewCell() {
        catFactsTableView.register(CatFactsTableViewCell.self, forCellReuseIdentifier: "factCell")
    }
    
    private func setupCatFactsViewModelDelegate() {
        catFactsViewModel.delegate = self
    }
    
    //MARK: - Setup UI
    private func setupMainStackViewUI() {
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        mainStackView.axis = .vertical
        mainStackView.spacing = 0
        mainStackView.alignment = .center
        mainStackView.distribution = .fillProportionally
    }
    
    private func setupCatFactsTableViewUI() {
        catFactsTableView.translatesAutoresizingMaskIntoConstraints = false
        catFactsTableView.delegate = self
        catFactsTableView.dataSource = self
    }
    
    //MARK: - Constraints
    private func setupMainStackViewConstraints() {
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mainStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            mainStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            mainStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func setupCatFactsTableViewConstraints() {
        NSLayoutConstraint.activate([
            catFactsTableView.heightAnchor.constraint(equalTo: mainStackView.heightAnchor),
            catFactsTableView.widthAnchor.constraint(equalTo: mainStackView.widthAnchor)
        ])
    }
}
//MARK: - Extensions
extension CatFactsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        catFacts.data?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell
        let fact = (catFacts.data?[indexPath.row])!
        cell = catFactsTableView.dequeueReusableCell(withIdentifier: "factCell", for: indexPath)
        
        if let factCell = cell as? CatFactsTableViewCell {
            factCell.configureCell(with: fact)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        "Cat Facts"
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}

extension CatFactsViewController: CatFactsViewModelDelegate {
    func catFactsFetched(_ catFacts: CatFactsModel) {
        self.catFacts = catFacts
        DispatchQueue.main.async {
            self.catFactsTableView.reloadData()
        }
    }
    
    func showError(_ error: Error) {
        print("error")
    }
}
