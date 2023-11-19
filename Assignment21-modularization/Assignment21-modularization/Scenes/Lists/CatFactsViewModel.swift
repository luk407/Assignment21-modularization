
import NetworkingPackage

protocol CatFactsViewModelDelegate: AnyObject {
    func catFactsFetched(_ catFacts: CatFactsModel)
    func showError(_ error: Error)
}

final class CatFactsViewModel {
    private var catFacts: CatFactsModel?
    
    weak var delegate: CatFactsViewModelDelegate?
    
    func viewDidLoad() {
        fetchCatFacts()
    }
    
    private func fetchCatFacts() {
        NetworkManager.shared.fetchData() { [weak self] (result: Result<CatFactsModel, Error>) in
            switch result {
            case .success(let facts):
                self?.catFacts = facts
                self?.delegate?.catFactsFetched(facts)
            case .failure(let error):
                print("df")
                self?.delegate?.showError(error)
            }
        }
    }
}
