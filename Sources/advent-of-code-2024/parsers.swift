import Parsing

@MainActor
let numbersSeparatedBySpace: some Parser<Substring, [Int]> =
	Many {
		Int.parser()
	} separator: {
		Whitespace()
	}
