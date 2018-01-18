function [objective_function, sos_program] = SetObjective(setup, decision_vars, sos_program)
    disp('VI: Setting objective.');
    a = decision_vars.a;
    b = decision_vars.b;
    q = setup.q;
    objective_function = b - sum( a.* q);
    sos_program = sossetobj(sos_program, objective_function);
end
