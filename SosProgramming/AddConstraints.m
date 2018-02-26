function sos_program = AddConstraints(scenario, fun_dir_index, decision_vars, sos_program)
    sos_program = AddOutwardFacetConstraintIfNecessary(scenario, fun_dir_index, decision_vars, sos_program);
    sos_program = AddInwardFacetConstraintsIfNecessary(scenario, decision_vars, sos_program);
    sos_program = AddValidityConstraint(scenario, decision_vars, sos_program);
end

function sos_program = AddOutwardFacetConstraintIfNecessary(scenario, fun_dir_index, decision_vars, sos_program)
    if ~ scenario.fix_normal
        fun_dirs = scenario.fundamental_directions;
        fun_dir = fun_dirs{fun_dir_index};
        NotifyUserAboutOuterFacetInequality(fun_dir);

        is_outward_ineq = true;
        sos_program = AddFacetIneq(fun_dir, decision_vars, is_outward_ineq, sos_program);
    end
end

function sos_program = AddFacetIneq(fun_dir, decision_vars, is_outward_ineq, sos_program)
    a = decision_vars.a;
    equation = sum(fun_dir .* a) - 1;
    if ~ is_outward_ineq
        equation = - 1 * equation;
    end
    sos_program = sosineq(sos_program, equation);
end

function NotifyUserAboutOuterFacetInequality(fun_dir)
    fun_dir_str = Vec2Str(fun_dir);
    fprintf('VI: Adding outer facet inequality for fundamental direction %s.\n', fun_dir_str);
end

function sos_program = AddInwardFacetConstraintsIfNecessary(scenario, decision_vars, sos_program)
    if TestIfObjectiveCanBeUnbounded(scenario)
        disp('VI: Adding additional inner facet inequalities to avoid unbounded objective.');

        fun_dirs = scenario.fundamental_directions;
        for i = 1:numel(fun_dirs)
            fun_dir = fun_dirs{i};
            is_outward_ineq = false;
            sos_program = AddFacetIneq(fun_dir, decision_vars, is_outward_ineq, sos_program);
        end
    end
end

function result = TestIfObjectiveCanBeUnbounded(scenario)
    result = (scenario.choice_obj_fun == scenariopack.Objective.b_only) && (~ scenario.fix_normal);
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
