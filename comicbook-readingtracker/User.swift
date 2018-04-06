import Foundation

class User {
    
    static var readComics: [Int] = [] {
        didSet {
            UserDefaults.standard.set(readComics, forKey: "ReadComicsIds")
        }
    }
}
