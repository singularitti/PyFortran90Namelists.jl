@pymutable Tokenizer o
Tokenizer() = Tokenizer(f90nml.tokenizer.Tokenizer())

update_chars(tk::Tokenizer) = tk.update_chars()

lex(tk::Tokenizer, line) = pyconvert(Vector{String}, tk.parse(line))
