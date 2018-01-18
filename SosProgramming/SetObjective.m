function [objective_function, sos_program] = SetObjective(setup, decision_vars, sos_program)
    disp('VI: Setting objective.');

    if setup.is_feasibility_variant
        objective_function = 0;
    else
        a = decision_vars.a;
        b = decision_vars.b;
        q = setup.q;

        objective_function = b - sum( a.* q);
    end

    sos_program = sossetobj(sos_program, objective_function);
end
