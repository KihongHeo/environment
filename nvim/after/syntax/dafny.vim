syntax spell notoplevel

syntax region dafnyString start=/"/ skip=/\\"/ end=/"/ contains=@Spell
syntax match dafnyComment /\/\/.*/ contains=@Spell
syntax region dafnyComment start="/\*" end="\*/" contains=@Spell
