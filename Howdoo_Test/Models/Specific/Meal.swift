import Foundation

struct Meal: Codable {
    let name: String
    let price: Double
    let image: URL
    let restaurantName: String
    
    // Decodable
    private enum CodingKeys: String, CodingKey {
        case name = "food_name", price, image = "image_url", restaurantName = "restaurant"
    }
}
