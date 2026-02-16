as yet unclassified
testWideString
	"Handle non-ASCII characters somewhat gracefully. Previous implementation was naively converting WideString input into bytes, resulting in many null values interleaved with actual characters"
	
	| decoder |
	decoder := SoupDecoder new.
	decoder string: '“Hello” World'.
	self assert: decoder decode equals: 'âHelloâ World'