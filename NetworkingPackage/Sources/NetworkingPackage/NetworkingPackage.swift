
import UIKit

public final class NetworkManager {
    public static var shared = NetworkManager()
    
    private let url = "https://catfact.ninja/facts"
    
    public init() {}
    
    public func fetchData<T: Decodable>(completion: @escaping (Result<T, Error>) -> (Void)) {
        let urlString = url
        
        guard let url = URL(string: urlString) else {
            print("f")
            completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("s")
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                print("asd")
                completion(.failure(NSError(domain: "", code: -2, userInfo: [NSLocalizedDescriptionKey: "No data received"])))
                return
            }
            
            do {
                let factsResponse = try JSONDecoder().decode(T.self, from: data)
                completion(.success(factsResponse))
            } catch {
                print(error)
                completion(.failure(error))
            }
        }.resume()
    }
}
