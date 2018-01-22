function solution = SolveOneFundamentalDirection(setup, fun_dir_index)
    sos_program = InitSosProgram(setup);

    [decision_vars, sos_program] = DeclareVariables(setup, sos_program);

    sos_program = AddConstraints(setup, fun_dir_index, decision_vars, sos_program);

    [objective_function, sos_program] = SetObjective(setup, decision_vars, sos_program);

    solution = CallSosSolver(setup, decision_vars, objective_function, sos_program);
end
