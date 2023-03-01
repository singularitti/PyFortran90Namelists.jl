using PyFortran90Namelists: f90nml, @pyinterface

mutable struct Tokenizer
    o::Py
end
Tokenizer() = Tokenizer(f90nml.tokenizer.Tokenizer())

@pyinterface Tokenizer

update_chars(tk::Tokenizer) = tk.update_chars()

lex(tk::Tokenizer, line) = pyconvert(Vector{String}, tk.parse(line))
