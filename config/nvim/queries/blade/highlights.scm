
; Blade directives like @section, @extends, @if, etc.
((directive) @keyword)
((directive_start) @keyword)
((directive_end) @keyword)

; Brackets used in @foreach($foo as $bar)
((bracket_start) @punctuation.bracket)
((bracket_end) @punctuation.bracket)

; Blade comments like {{-- comment --}}
((comment) @comment @spell)
