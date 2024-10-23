import Testing

@testable import advent_of_code_2024

@Test("With specific name") func testWithName() {
	#expect(true == true)
}

@Test func example() async throws {
	// Write your test here and use APIs like `#expect(...)` to check expected conditions.
}

@Test func can_parse_scores() {
	let test_input = "41 48 83 86 17"
	do {
		let output = try scores().parse(test_input)
		#expect(output == [41, 48, 83, 86, 17])
	} catch {
		#expect(Bool(false), "Unable to parse scores")
	}
}

@Test func can_parse_card_number() {
	let test_input = "Card 1:"
	do {
		let output = try cardNumber().parse(test_input)
		#expect(output == 1)
	} catch {
		#expect(Bool(false), "Unable to parse")
	}
}

@Test func basic_score_card() {
	let test_input = "Card 1: 41 48 83 86 17 | 83 86  6 31 17  9 48 53"
	do {
		let output = try scoreCard().parse(test_input)
		#expect(output.number == 1)
		#expect(output.winners == [41, 48, 83, 86, 17])
		#expect(output.current == [83, 86, 6, 31, 17, 9, 48, 53])
	} catch {
		#expect(Bool(false), "Unable to parse")
	}
}
