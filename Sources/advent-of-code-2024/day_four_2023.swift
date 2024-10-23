import Parsing

public struct Card {
	var number: Int
	var winners: [Int]
	var current: [Int]
}

// What are these 'any' or 'some' annotations?
public func cardParser() -> any Parser<Substring, Card> {
	let numbers: some Parser<Substring, [Int]> = Many {
		Int.parser()
	} separator: {
		" "
	}
	return Parse(
		input: Substring.self, Card.init
	) {
		"Card"
		Int.parser()
		":"
		numbers
		"|"
		numbers
	}
}
