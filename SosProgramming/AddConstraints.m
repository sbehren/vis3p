function sos_program = AddConstraints(setup, fun_dir_index, decision_vars, sos_program)
    sos_program = AddFacetConstraints(setup, fun_dir_index, decision_vars, sos_program);
    sos_program = AddValidityConstraint(setup, decision_vars, sos_program);
end

function sos_program = AddFacetConstraints(setup, fun_dir_index, decision_vars, sos_program)
    a = decision_vars.a;
    fun_dirs = setup.fundamental_directions;

    fun_dir = fun_dirs{fun_dir_index};
    fun_dir_str = sprintf('%d ', fun_dir);
    fprintf('VI: Adding equation for fundamental direction %s.\n', fun_dir_str);

    if ~ setup.normal_is_fixed
        equation = sum(fun_dir .* a) - 1;
        sos_program = sosineq(sos_program, equation);
    end
end

function sos_program = AddValidityConstraint(setup, decision_vars, sos_program)
    x = setup.vartable;

    a = decision_vars.a;
    b = decision_vars.b;
    sigma = decision_vars.sigma;

    g = setup.constraints;

    hyperplane_poly = b - sum(a .* x);

    disp('VI: Adding constraint.')
    constraint = hyperplane_poly - sum(sigma .* g);

    sos_program = sosineq(sos_program, constraint);
end
