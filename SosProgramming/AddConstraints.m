function sos_program = AddConstraints(scenario, fun_dir_index, decision_vars, sos_program)
    sos_program = AddFacetConstraints(scenario, fun_dir_index, decision_vars, sos_program);
    sos_program = AddValidityConstraint(scenario, decision_vars, sos_program);
end

function sos_program = AddFacetConstraints(scenario, fun_dir_index, decision_vars, sos_program)
    a = decision_vars.a;
    fun_dirs = scenario.fundamental_directions;

    fun_dir = fun_dirs{fun_dir_index};
    fun_dir_str = Vec2Str(fun_dir);
    fprintf('VI: Adding equation for fundamental direction %s.\n', fun_dir_str);

    if ~ scenario.fix_normal
        equation = sum(fun_dir .* a) - 1;
        sos_program = sosineq(sos_program, equation);
    end
end

function sos_program = AddValidityConstraint(scenario, decision_vars, sos_program)
    x = scenario.vartable;

    a = decision_vars.a;
    b = decision_vars.b;
    sigma = decision_vars.sigma;

    g = scenario.constraints;

    hyperplane_poly = b - sum(a .* x);

    disp('VI: Adding constraint that enforces a valid inequality.')
    constraint = hyperplane_poly - sum(sigma .* g);

    sos_program = sosineq(sos_program, constraint);
end
