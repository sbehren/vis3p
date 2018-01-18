function [objective_function, sos_program] = SetObjective(setup, decision_vars, sos_program)
    disp('VI: Setting objective.');

    a = decision_vars.a;
    b = decision_vars.b;
    q = setup.q;

    if setup.is_feasibility_variant
        if setup.normal_is_fixed
            objective_function = b;
        else
            objective_function = 0;
        end
    else
        objective_function = b - sum( a.* q);
    end

    sos_program = sossetobj(sos_program, objective_function);
end
