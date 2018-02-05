function solution = SolveOneFundamentalDirection(scenario, fun_dir_index)
    sos_program = InitSosProgram(scenario);

    [decision_vars, sos_program] = DeclareVariables(scenario, sos_program);

    sos_program = AddConstraints(scenario, fun_dir_index, decision_vars, sos_program);

    [objective_function, sos_program] = SetObjective(scenario, decision_vars, sos_program);

    solution = CallSosSolver(scenario, decision_vars, objective_function, sos_program);
end
