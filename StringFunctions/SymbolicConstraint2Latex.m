function result = SymbolicConstraint2Latex(sym_expr)
    raw = char(sym_expr);
    result = strrep(raw, 'x', 'X_');
end
