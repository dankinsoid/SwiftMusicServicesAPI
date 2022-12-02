import Foundation

// MARK: - Public

public func MD5(_ input: String) -> String {
	hex_md5(input)
}

// MARK: - Functions

func hex_md5(_ input: String) -> String {
	rstr2hex(rstr_md5(str2rstr_utf8(input)))
}

func str2rstr_utf8(_ input: String) -> [CUnsignedChar] {
	Array(input.utf8)
}

func rstr2tr(_ input: [CUnsignedChar]) -> String {
	var output = ""

	input.forEach {
		output.append(String(UnicodeScalar($0)))
	}

	return output
}

/*
 * Convert a raw string to a hex string
 */
func rstr2hex(_ input: [CUnsignedChar]) -> String {
	let hexTab: [Character] = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "A", "B", "C", "D", "E", "F"]
	var output: [Character] = []

	for i in 0 ..< input.count {
		let x = input[i]
		let value1 = hexTab[Int((x >> 4) & 0x0F)]
		let value2 = hexTab[Int(Int32(x) & 0x0F)]

		output.append(value1)
		output.append(value2)
	}

	return String(output)
}

/*
 * Convert a raw string to an array of little-endian words
 * Characters >255 have their high-byte silently ignored.
 */
func rstr2binl(_ input: [CUnsignedChar]) -> [Int32] {
	var output: [Int: Int32] = [:]

	for i in stride(from: 0, to: input.count * 8, by: 8) {
		let value: Int32 = (Int32(input[i / 8]) & 0xFF) << (Int32(i) % 32)

		output[i >> 5] = unwrap(output[i >> 5]) | value
	}

	return dictionary2array(output)
}

/*
 * Convert an array of little-endian words to a string
 */
func binl2rstr(_ input: [Int32]) -> [CUnsignedChar] {
	var output: [CUnsignedChar] = []

	for i in stride(from: 0, to: input.count * 32, by: 8) {
		// [i>>5] >>>
		let value: Int32 = zeroFillRightShift(input[i >> 5], Int32(i % 32)) & 0xFF
		output.append(CUnsignedChar(value))
	}

	return output
}

/*
 * Calculate the MD5 of a raw string
 */
func rstr_md5(_ input: [CUnsignedChar]) -> [CUnsignedChar] {
	binl2rstr(binl_md5(rstr2binl(input), input.count * 8))
}

/*
 * Add integers, wrapping at 2^32. This uses 16-bit operations internally
 * to work around bugs in some JS interpreters.
 */
func safe_add(_ x: Int32, _ y: Int32) -> Int32 {
	let lsw = (x & 0xFFFF) + (y & 0xFFFF)
	let msw = (x >> 16) + (y >> 16) + (lsw >> 16)
	return (msw << 16) | (lsw & 0xFFFF)
}

/*
 * Bitwise rotate a 32-bit number to the left.
 */
func bit_rol(_ num: Int32, _ cnt: Int32) -> Int32 {
	// num >>>
	(num << cnt) | zeroFillRightShift(num, 32 - cnt)
}

/*
 * These funcs implement the four basic operations the algorithm uses.
 */
func md5_cmn(_ q: Int32, _ a: Int32, _ b: Int32, _ x: Int32, _ s: Int32, _ t: Int32) -> Int32 {
	safe_add(bit_rol(safe_add(safe_add(a, q), safe_add(x, t)), s), b)
}

func md5_ff(_ a: Int32, _ b: Int32, _ c: Int32, _ d: Int32, _ x: Int32, _ s: Int32, _ t: Int32) -> Int32 {
	md5_cmn((b & c) | ((~b) & d), a, b, x, s, t)
}

func md5_gg(_ a: Int32, _ b: Int32, _ c: Int32, _ d: Int32, _ x: Int32, _ s: Int32, _ t: Int32) -> Int32 {
	md5_cmn((b & d) | (c & ~d), a, b, x, s, t)
}

func md5_hh(_ a: Int32, _ b: Int32, _ c: Int32, _ d: Int32, _ x: Int32, _ s: Int32, _ t: Int32) -> Int32 {
	md5_cmn(b ^ c ^ d, a, b, x, s, t)
}

func md5_ii(_ a: Int32, _ b: Int32, _ c: Int32, _ d: Int32, _ x: Int32, _ s: Int32, _ t: Int32) -> Int32 {
	md5_cmn(c ^ (b | ~d), a, b, x, s, t)
}

/*
 * Calculate the MD5 of an array of little-endian words, and a bit length.
 */
func binl_md5(_ input: [Int32], _ len: Int) -> [Int32] {
	/* append padding */

	var x: [Int: Int32] = [:]
	for (index, value) in input.enumerated() {
		x[index] = value
	}

	let value: Int32 = 0x80 << Int32(len % 32)
	x[len >> 5] = unwrap(x[len >> 5]) | value

	// >>> 9
	let index = (((len + 64) >> 9) << 4) + 14
	x[index] = unwrap(x[index]) | Int32(len)

	var a: Int32 = 1_732_584_193
	var b: Int32 = -271_733_879
	var c: Int32 = -1_732_584_194
	var d: Int32 = 271_733_878

	for i in stride(from: 0, to: length(x), by: 16) {
		let olda: Int32 = a
		let oldb: Int32 = b
		let oldc: Int32 = c
		let oldd: Int32 = d

		a = md5_ff(a, b, c, d, unwrap(x[i + 0]), 7, -680_876_936)
		d = md5_ff(d, a, b, c, unwrap(x[i + 1]), 12, -389_564_586)
		c = md5_ff(c, d, a, b, unwrap(x[i + 2]), 17, 606_105_819)
		b = md5_ff(b, c, d, a, unwrap(x[i + 3]), 22, -1_044_525_330)
		a = md5_ff(a, b, c, d, unwrap(x[i + 4]), 7, -176_418_897)
		d = md5_ff(d, a, b, c, unwrap(x[i + 5]), 12, 1_200_080_426)
		c = md5_ff(c, d, a, b, unwrap(x[i + 6]), 17, -1_473_231_341)
		b = md5_ff(b, c, d, a, unwrap(x[i + 7]), 22, -45_705_983)
		a = md5_ff(a, b, c, d, unwrap(x[i + 8]), 7, 1_770_035_416)
		d = md5_ff(d, a, b, c, unwrap(x[i + 9]), 12, -1_958_414_417)
		c = md5_ff(c, d, a, b, unwrap(x[i + 10]), 17, -42063)
		b = md5_ff(b, c, d, a, unwrap(x[i + 11]), 22, -1_990_404_162)
		a = md5_ff(a, b, c, d, unwrap(x[i + 12]), 7, 1_804_603_682)
		d = md5_ff(d, a, b, c, unwrap(x[i + 13]), 12, -40_341_101)
		c = md5_ff(c, d, a, b, unwrap(x[i + 14]), 17, -1_502_002_290)
		b = md5_ff(b, c, d, a, unwrap(x[i + 15]), 22, 1_236_535_329)

		a = md5_gg(a, b, c, d, unwrap(x[i + 1]), 5, -165_796_510)
		d = md5_gg(d, a, b, c, unwrap(x[i + 6]), 9, -1_069_501_632)
		c = md5_gg(c, d, a, b, unwrap(x[i + 11]), 14, 643_717_713)
		b = md5_gg(b, c, d, a, unwrap(x[i + 0]), 20, -373_897_302)
		a = md5_gg(a, b, c, d, unwrap(x[i + 5]), 5, -701_558_691)
		d = md5_gg(d, a, b, c, unwrap(x[i + 10]), 9, 38_016_083)
		c = md5_gg(c, d, a, b, unwrap(x[i + 15]), 14, -660_478_335)
		b = md5_gg(b, c, d, a, unwrap(x[i + 4]), 20, -405_537_848)
		a = md5_gg(a, b, c, d, unwrap(x[i + 9]), 5, 568_446_438)
		d = md5_gg(d, a, b, c, unwrap(x[i + 14]), 9, -1_019_803_690)
		c = md5_gg(c, d, a, b, unwrap(x[i + 3]), 14, -187_363_961)
		b = md5_gg(b, c, d, a, unwrap(x[i + 8]), 20, 1_163_531_501)
		a = md5_gg(a, b, c, d, unwrap(x[i + 13]), 5, -1_444_681_467)
		d = md5_gg(d, a, b, c, unwrap(x[i + 2]), 9, -51_403_784)
		c = md5_gg(c, d, a, b, unwrap(x[i + 7]), 14, 1_735_328_473)
		b = md5_gg(b, c, d, a, unwrap(x[i + 12]), 20, -1_926_607_734)

		a = md5_hh(a, b, c, d, unwrap(x[i + 5]), 4, -378_558)
		d = md5_hh(d, a, b, c, unwrap(x[i + 8]), 11, -2_022_574_463)
		c = md5_hh(c, d, a, b, unwrap(x[i + 11]), 16, 1_839_030_562)
		b = md5_hh(b, c, d, a, unwrap(x[i + 14]), 23, -35_309_556)
		a = md5_hh(a, b, c, d, unwrap(x[i + 1]), 4, -1_530_992_060)
		d = md5_hh(d, a, b, c, unwrap(x[i + 4]), 11, 1_272_893_353)
		c = md5_hh(c, d, a, b, unwrap(x[i + 7]), 16, -155_497_632)
		b = md5_hh(b, c, d, a, unwrap(x[i + 10]), 23, -1_094_730_640)
		a = md5_hh(a, b, c, d, unwrap(x[i + 13]), 4, 681_279_174)
		d = md5_hh(d, a, b, c, unwrap(x[i + 0]), 11, -358_537_222)
		c = md5_hh(c, d, a, b, unwrap(x[i + 3]), 16, -722_521_979)
		b = md5_hh(b, c, d, a, unwrap(x[i + 6]), 23, 76_029_189)
		a = md5_hh(a, b, c, d, unwrap(x[i + 9]), 4, -640_364_487)
		d = md5_hh(d, a, b, c, unwrap(x[i + 12]), 11, -421_815_835)
		c = md5_hh(c, d, a, b, unwrap(x[i + 15]), 16, 530_742_520)
		b = md5_hh(b, c, d, a, unwrap(x[i + 2]), 23, -995_338_651)

		a = md5_ii(a, b, c, d, unwrap(x[i + 0]), 6, -198_630_844)
		d = md5_ii(d, a, b, c, unwrap(x[i + 7]), 10, 1_126_891_415)
		c = md5_ii(c, d, a, b, unwrap(x[i + 14]), 15, -1_416_354_905)
		b = md5_ii(b, c, d, a, unwrap(x[i + 5]), 21, -57_434_055)
		a = md5_ii(a, b, c, d, unwrap(x[i + 12]), 6, 1_700_485_571)
		d = md5_ii(d, a, b, c, unwrap(x[i + 3]), 10, -1_894_986_606)
		c = md5_ii(c, d, a, b, unwrap(x[i + 10]), 15, -1_051_523)
		b = md5_ii(b, c, d, a, unwrap(x[i + 1]), 21, -2_054_922_799)
		a = md5_ii(a, b, c, d, unwrap(x[i + 8]), 6, 1_873_313_359)
		d = md5_ii(d, a, b, c, unwrap(x[i + 15]), 10, -30_611_744)
		c = md5_ii(c, d, a, b, unwrap(x[i + 6]), 15, -1_560_198_380)
		b = md5_ii(b, c, d, a, unwrap(x[i + 13]), 21, 1_309_151_649)
		a = md5_ii(a, b, c, d, unwrap(x[i + 4]), 6, -145_523_070)
		d = md5_ii(d, a, b, c, unwrap(x[i + 11]), 10, -1_120_210_379)
		c = md5_ii(c, d, a, b, unwrap(x[i + 2]), 15, 718_787_259)
		b = md5_ii(b, c, d, a, unwrap(x[i + 9]), 21, -343_485_551)

		a = safe_add(a, olda)
		b = safe_add(b, oldb)
		c = safe_add(c, oldc)
		d = safe_add(d, oldd)
	}

	return [a, b, c, d]
}

// MARK: - Helper

func length(_ dictionary: [Int: Int32]) -> Int {
	(dictionary.keys.max() ?? 0) + 1
}

func dictionary2array(_ dictionary: [Int: Int32]) -> [Int32] {
	var array = [Int32](repeating: 0, count: dictionary.keys.count)

	for i in Array(dictionary.keys).sorted() {
		array[i] = unwrap(dictionary[i])
	}

	return array
}

func unwrap(_ value: Int32?, _ fallback: Int32 = 0) -> Int32 {
	if let value {
		return value
	}

	return fallback
}

func zeroFillRightShift(_ num: Int32, _ count: Int32) -> Int32 {
	let value = UInt32(bitPattern: num) >> UInt32(bitPattern: count)
	return Int32(bitPattern: value)
}
