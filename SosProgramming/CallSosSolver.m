function solution = CallSosSolver(setup, decision_vars, objective_function, sos_program)
    solution = ValidInequality;
    solution.InitUndefined();
    sdp_solver_options.solver = setup.sdp_solver;

    try
        disp('VI: Attempting to solve sos program.');
        [sos_program, solver_info] = CallSolver(sos_program, sdp_solver_options);
        solution = EvaluateSolution(solution, solver_info);
    catch ME
        disp('VI: WARNING: Not possible to compute valid inequality!');
        disp(['VI: Error message: ' ME.message]);
    end

    if solution.solved
        try
            solution = GetSolutions(decision_vars, objective_function, solution, sos_program);
        catch ME
            disp('VI: Not possible to get solutions.');
            disp(['VI solution error message: ' ME.message]);
        end
    else
        disp('VI: No valid inequality found.');
    end
end

function [sos_program, solver_info] = CallSolver(sos_program, sdp_solver_options)
    [sos_program, solver_info] = sossolve(sos_program, sdp_solver_options);
end

function solution = EvaluateSolution(solution, solver_info)
    if solver_info.pinf == 0 && solver_info.dinf == 0 
        if isfield(solver_info, 'numerr')
            solution.numerical_errors = solver_info.numerr;
        end
        solution.solved = true;
    end
end

function solution = GetSolutions(decision_vars, objective_function, solution, sos_program)
    solution.objective = GetOptimalSolution(objective_function, sos_program);
    solution.a = GetOptimalSolution(decision_vars.a, sos_program);
    solution.b = GetOptimalSolution(decision_vars.b, sos_program);
    disp(['VI: Sos program successfully solved. The bound found is ' num2str(solution.objective) '.']);
end

function value = GetOptimalSolution(variable, sos_program)
    value = double(sosgetsol(sos_program, variable, 12));
end
