import Parsing

public struct ScoreCard {
	var number: Int
	var winners: [Int]
	var current: [Int]
}

extension ScoreCard {
	var points: Int {
		let winnersSet = Set(self.winners)
		let currentSet = Set(self.current)
		let total = currentSet.intersection(winnersSet).count
		return switch total {
		case 0:
			0
		case 1:
			1
		default:
			2 << (total - 2)
		}
	}
}

@MainActor
let cardNumber: some Parser<Substring, Int> =
	Parse {
		"Card"
		Whitespace()
		Int.parser()
		":"
	}

// What are these 'any' or 'some' annotations?
@MainActor
let scoreCard: some Parser<Substring, ScoreCard> =
	Parse(
		input: Substring.self, ScoreCard.init
	) {
		cardNumber
		Whitespace()
		numbersSeparatedBySpace
		Whitespace()
		"|"
		Whitespace()
		numbersSeparatedBySpace
	}

@MainActor
let scoreCards: some Parser<Substring, [ScoreCard]> =
	Many {
		scoreCard
	} separator: {
		"\n"
	} terminator: {
		End()
	}
