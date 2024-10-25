import Parsing

public struct ScoreCard {
	var number: Int
	var winners: [Int]
	var current: [Int]
}

extension ScoreCard {
	var winningNumbers: Int {
		let winnersSet = Set(self.winners)
		let currentSet = Set(self.current)
		return currentSet.intersection(winnersSet).count
	}

	var points: Int {
		return switch self.winningNumbers {
		case 0:
			0
		case 1:
			1
		default:
			2 << (self.winningNumbers - 2)
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

public func countScoreCards(input: [ScoreCard]) -> Int {
	func insertOrAddOne(key: Int, dict: inout [Int: Int]) {
		if let x = dict[key] {
			dict[key] = x + 1
		} else {
			dict[key] = 1
		}
	}

	var scoreCardCounts: [Int: Int] = [:]
	for inp in input {
		let currentNumber = inp.number
		let winningNumbers = inp.winningNumbers
		// Add our current score card
		insertOrAddOne(key: currentNumber, dict: &scoreCardCounts)

		if winningNumbers != 0 {
			// Insert initial cards winning score cards
			(currentNumber + 1...currentNumber + winningNumbers).forEach { x in
				insertOrAddOne(key: x, dict: &scoreCardCounts)
			}

			// Insert any copies
			if let currentCount = scoreCardCounts[currentNumber] {
				if currentCount > 1 {
					let numCopies = currentCount - 1
					(1...numCopies).forEach { x in
						(currentNumber + 1...currentNumber + winningNumbers).forEach { y in
							insertOrAddOne(key: y, dict: &scoreCardCounts)
						}
					}
				}
			}
		}
	}
	return scoreCardCounts.reduce(
		0, { (acc: Int, elem: Dictionary<Int, Int>.Element) -> Int in return acc + elem.value })
}
