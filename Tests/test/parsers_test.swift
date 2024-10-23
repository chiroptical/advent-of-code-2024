import Testing

@testable import advent_of_code_2024

@MainActor
@Test func can_parse_numbers_separated_by_spaces() {
	let test_input = "41 48 83 86 17"
	do {
		let output = try numbersSeparatedBySpace.parse(test_input)
		#expect(output == [41, 48, 83, 86, 17])
	} catch {
		#expect(Bool(false), "Unable to parse scores")
	}
}
