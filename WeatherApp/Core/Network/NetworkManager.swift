import Foundation

/**
 Sould Know:
 1. What is a Generic Type:
    - Instead of writing the same code multiple times for different types (Int, String, User, etc.), you write it once, and Swift fills in the actual type later.
 2. Why Generics Exist:
    - If we want to printInt(value: Int) & printString(value: String) no need to write two diff func. printValue<T>(value: T) work for all data types.
 3. What does <T> mean?
    - <T> introduces a generic type parameter. T is just a name (can be anything: T, U, Element). Swift replaces T with a real type when the function is called.
 4. Generics with Constraints
    - Sometimes you want generics but with rules. For example _T: Decodable_, here T must conform to this protocol.
 */

class NetworkManager {
    
    static let shared = NetworkManager()
    private init() {}
    
    func request<T: Decodable>(endpoint: APIEndpoint, completion: @escaping (Result<T, NetworkError>) -> Void) {
        guard let url = endpoint.url else {
            completion(.failure(.invalidURL))
            return
        }
        
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(.serverError(error.localizedDescription)))
            }
            
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            
            do {
                let decodeData = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decodeData))
            } catch {
                completion(.failure(.decodingError))
            }
        }.resume()
    }
}
