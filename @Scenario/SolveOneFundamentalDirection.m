function solution = SolveOneFundamentalDirection(obj, fun_dir_index)
    sos_program = InitSosProgram(obj);

    [decision_vars, sos_program] = DeclareVariables(obj, sos_program);

    sos_program = AddConstraints(obj, fun_dir_index, decision_vars, sos_program);

    [objective_function, sos_program] = SetObjective(obj, decision_vars, sos_program);

    solution = CallSosSolver(obj, decision_vars, objective_function, sos_program);
end
