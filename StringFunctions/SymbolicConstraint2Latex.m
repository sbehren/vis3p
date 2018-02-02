function result = SymbolicConstraint2Latex(sym_expr)
    raw_str = GetRawRepresentation(sym_expr);

    capitalized_var = CapitalizeVariables(raw_str);

    result = RemoveMultiplicationOperator(capitalized_var);
end

function raw_str = GetRawRepresentation(sym_expr)
    raw_str = char(sym_expr);
end

function capitalized_var = CapitalizeVariables(str)
    capitalized_var = strrep(str, 'x', 'X_');
end

function result = RemoveMultiplicationOperator(str)
    result = strrep(str, '*', '');
end
