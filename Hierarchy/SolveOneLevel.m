function solution = SolveOneLevel(setup, order, fun_dir_index)
    sos_program = InitSosProgram(setup);

    [decision_vars, sos_program] = DeclareVariables(setup, order, sos_program);

    sos_program = AddConstraints(setup, fun_dir_index, decision_vars, sos_program);

    [objective_function, sos_program] = SetObjective(setup, decision_vars, sos_program);

    solution = CallSosSolver(setup, decision_vars, objective_function, sos_program);
end

function sos_program = InitSosProgram(setup)
    sos_program = sosprogram(setup.vartable);
end

function [objective_function, sos_program] = SetObjective(setup, decision_vars, sos_program)
    disp('VI: Setting objective.');
    a = decision_vars.a;
    b = decision_vars.b;
    q = setup.q;
    objective_function = b - sum( a.* q);
    sos_program = sossetobj(sos_program, objective_function);
end
