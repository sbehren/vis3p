function sos_program = AddConstraints(setup, fun_dir_index, decision_polys, sos_program)
    sos_program = AddFacetConstraints(setup, fun_dir_index, decision_polys, sos_program);
    sos_program = AddValidityConstraint(setup, decision_polys, sos_program);
end

function sos_program = AddFacetConstraints(setup, fun_dir_index, decision_polys, sos_program)
    a = decision_polys.a;
    fun_dirs = setup.fundamental_directions;

    %for index = 1:length(fun_dirs)
    %    fun_dir = fun_dirs{index};
    %    fun_dir_str = sprintf('%d ', fun_dir);
    %    fprintf('VI: Adding equation for fundamental direction %s.\n', fun_dir_str);
    %    equation = 1 - sum(fun_dir .* a);
    %    if index ~= fun_dir_index
    %        sos_program = sosineq(sos_program, equation);
    %    else
    %        sos_program = soseq(sos_program, equation);
    %    end
    %end

    fun_dir = fun_dirs{fun_dir_index};
    fun_dir_str = sprintf('%d ', fun_dir);
    fprintf('VI: Adding equation for fundamental direction %s.\n', fun_dir_str);

    equation = sum(fun_dir .* a) - 1;
    sos_program = sosineq(sos_program, equation);
end

function sos_program = AddValidityConstraint(setup, decision_polys, sos_program)
    x = setup.vartable;

    a = decision_polys.a;
    b = decision_polys.b;
    sigma = decision_polys.sigma;

    g = setup.constraints;

    hyperplane_poly = b - sum(a .* x);

    disp('VI: Adding constraint.')
    constraint = hyperplane_poly - sum(sigma .* g);

    sos_program = sosineq(sos_program, constraint);
end
