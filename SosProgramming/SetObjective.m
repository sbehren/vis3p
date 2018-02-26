function [objective_function, sos_program] = SetObjective(scenario, decision_vars, sos_program)
    disp('VI: Setting objective.');

    a = decision_vars.a;
    b = decision_vars.b;
    q = scenario.q;

    switch scenario.choice_obj_fun
        case scenariopack.Objective.b_only
            objective_function = b;
        case scenariopack.Objective.zero
            objective_function = 0;
        case scenariopack.Objective.distance
            objective_function = b - sum( a.* q);
        otherwise
            error('VI: Objective invalid')
    end

    sos_program = sossetobj(sos_program, objective_function);
end
