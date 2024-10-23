import Testing

@testable import advent_of_code_2024

@MainActor
@Test func can_parse_card_number() {
	let test_input = "Card 1:"
	do {
		let output = try cardNumber.parse(test_input)
		#expect(output == 1)
	} catch {
		#expect(Bool(false), "Unable to parse")
	}
}

@MainActor
@Test func can_parse_card_one() {
	let test_input = "Card 1: 41 48 83 86 17 | 83 86  6 31 17  9 48 53"
	do {
		let output = try scoreCard.parse(test_input)
		#expect(output.number == 1)
		#expect(output.winners == [41, 48, 83, 86, 17])
		#expect(output.current == [83, 86, 6, 31, 17, 9, 48, 53])
	} catch {
		#expect(Bool(false), "Unable to parse")
	}
}

@MainActor
@Test func can_parse_card_three() {
	let test_input = "Card 3:  1 21 53 59 44 | 69 82 63 72 16 21 14  1"
	do {
		let output = try scoreCard.parse(test_input)
		#expect(output.number == 3)
		#expect(output.winners == [1, 21, 53, 59, 44])
		#expect(output.current == [69, 82, 63, 72, 16, 21, 14, 1])
	} catch {
		#expect(Bool(false), "Unable to parse")
	}
}

@MainActor
@Test func can_parse_two_cards() {
	let test_input = """
		Card 1: 41 48 83 86 17 | 83 86  6 31 17  9 48 53
		Card 3:  1 21 53 59 44 | 69 82 63 72 16 21 14  1
		"""
	do {
		let output = try scoreCards.parse(test_input)
		#expect(output.count == 2)
	} catch {
		#expect(Bool(false), "Unable to parse")
	}
}

@Test func card_one_score_is_correct() {
	let card = ScoreCard(
		number: 1, winners: [41, 48, 83, 86, 17], current: [83, 86, 6, 31, 17, 9, 48, 53])
	#expect(card.points == 8)
}

@Test func card_three_points_is_correct() {
	let card = ScoreCard(
		number: 3, winners: [1, 21, 53, 59, 44], current: [69, 82, 63, 72, 16, 21, 14, 1])
	#expect(card.points == 2)
}

@Test func card_four_points_is_correct() {
	let card = ScoreCard(
		number: 4, winners: [41, 92, 73, 84, 69], current: [59, 84, 76, 51, 58, 5, 54, 83])
	#expect(card.points == 1)
}

@Test func card_five_points_is_correct() {
	let card = ScoreCard(
		number: 5, winners: [87, 83, 26, 28, 32], current: [88, 30, 70, 12, 93, 22, 82, 36])
	#expect(card.points == 0)
}
