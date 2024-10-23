import Parsing

let input = """
	1,Blob,true
	2,Blob Jr.,false
	3,Blob Sr.,true
	"""

public struct User {
	var id: Int
	var name: String
	var isAdmin: Bool
}

// Neat that you can make this lambda easily, you can't do it in any order though
// Would need to add another initializer
// Not concurrency safe if it isn't 'Sendable'
let x: @Sendable (Int, String, Bool) -> User = User.init(id:name:isAdmin:)

public func userParser() -> any Parser<Substring, User> {
	return Parse(input: Substring.self, User.init(id:name:isAdmin:)) {
		Int.parser()
		","
		Prefix { $0 != "," }.map(String.init)
		","
		Bool.parser()
	}
}
