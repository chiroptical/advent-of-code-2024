import Parsing

public struct ScoreCard {
	var number: Int
	var winners: [Int]
	var current: [Int]
}

public func scores() -> some Parser<Substring, [Int]> {
	return Many {
		Int.parser()
	} separator: {
		Whitespace()
	}
}

public func cardNumber() -> some Parser<Substring, Int> {
	return Parse {
		"Card"
		Whitespace()
		Int.parser()
		":"
	}
}

// What are these 'any' or 'some' annotations?
public func scoreCard() -> any Parser<Substring, ScoreCard> {
	return Parse(
		input: Substring.self, ScoreCard.init
	) {
		cardNumber()
		Whitespace()
		scores()
		" | "
		scores()
	}
}
