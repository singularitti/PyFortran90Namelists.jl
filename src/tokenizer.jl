using PyCall: PyObject

using PyFortran90Namelists: f90nml, @pyinterface

export Tokenizer, update_chars, lex

mutable struct Tokenizer
    o::PyObject
end
Tokenizer() = Tokenizer(f90nml.Tokenizer())

update_chars(tk::Tokenizer) = tk.update_chars()

lex(tk::Tokenizer, line) = tk.parse(line)

@pyinterface Tokenizer
