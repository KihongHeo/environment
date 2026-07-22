syntax spell notoplevel

syntax region coqProofComment contained contains=coqProofComment,coqTodo,@Spell start="(\*" end="\*)" extend keepend
syntax region coqString start=+"+ skip=+""+ end=+"+ contains=@Spell extend
syntax region elpiComment contained start="%" end="$" contains=@Spell extend
syntax region elpiString contained start=+"+ skip=+\\"+ end=+"+ contains=@Spell extend
