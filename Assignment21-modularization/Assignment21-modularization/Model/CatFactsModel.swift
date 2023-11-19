
import Foundation

struct CatFactsModel: Decodable {
    struct Fact: Decodable {
        let fact: String
    }
    
    let data: [Fact]?
}

