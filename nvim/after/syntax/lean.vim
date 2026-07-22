syntax spell notoplevel

syntax region leanInterpolatedString start='s!"' end='"' contains=leanInterpolation,leanStringEscape,@Spell
syntax region leanString start='"' end='"' contains=leanStringEscape,@Spell
