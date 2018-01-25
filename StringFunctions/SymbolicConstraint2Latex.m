function result = SymbolicConstraint2Latex(sym_expr, index)
    raw = char(sym_expr);
    not_padded = strrep(raw, 'x', 'x_');
    result = ['$g_', num2str(index), '=', not_padded, '$'];
end
