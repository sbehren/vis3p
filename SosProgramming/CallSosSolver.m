function solution = CallSosSolver(scenario, decision_vars, objective_function, sos_program)
    solution = LinearInequality();
    sdp_solver_options.solver = scenario.sdp_solver;

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
    if isfield(solver_info, 'numerr')
        solution.numerical_errors = solver_info.numerr;
    end
    if SolutionIsFeasible(solver_info) && ~ SolutionHasNumericalErrors(solution)
        solution.solved = true;
    else
        solution.solved = false;
    end
end

function is_feasible = SolutionIsFeasible(solver_info)
    is_feasible = solver_info.pinf == 0 && solver_info.dinf == 0;
end

function has_errors = SolutionHasNumericalErrors(solution)
    errorcode = solution.numerical_errors;
    if ~ isnan(errorcode) && errorcode ~= 0
        has_errors = true;
    else
        has_errors = false;
    end
end

function solution = GetSolutions(decision_vars, objective_function, solution, sos_program)
    solution.objective = GetOptimalSolution(objective_function, sos_program);
    solution.a = GetOptimalSolution(decision_vars.a, sos_program);
    solution.b = GetOptimalSolution(decision_vars.b, sos_program);
    disp('VI: Sos program successfully solved.');
end

function value = GetOptimalSolution(variable, sos_program)
    value = double(sosgetsol(sos_program, variable, 12));
end
