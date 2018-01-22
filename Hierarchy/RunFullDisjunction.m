function result = RunFullDisjunction(setup)
    NotifyUserStartingHierarchy(setup);
    result = ComputeOneValidInequality(setup);
    NotifyUserAboutSolution(result);
end

function best = ComputeOneValidInequality(setup)
    best = Result();

    fun_dirs = setup.fundamental_directions;

    for fun_dir_index = 1:length(fun_dirs)
        solution = SolveOneFundamentalDirection(setup, fun_dir_index);
        NotifyUserAboutSolution(solution);
        best = CompareBestWithCurrent(best, solution);
    end
    best.InitLinearFunction(setup.vartable);
    NotifyUserOneLevelOfHierarchySolved(setup);
end

function best = CompareBestWithCurrent(best, solution)
    if solution.solved && best.objective > solution.objective
        NotifyUserBetterSolutionFound();
        best.objective = solution.objective;
        best.a = solution.a;
        best.b = solution.b;
    end
end

function NotifyUserStartingHierarchy(setup)
    fprintf('\n\n************************************\n');
    fprintf('VI: At scenario %s.\n', setup.name);
    fprintf('VI: Starting k = %dth truncation order.\n', setup.truncation_order);
end

function NotifyUserOneLevelOfHierarchySolved(setup)
    fprintf('VI: Done for M[k] with k = %d.\n', setup.truncation_order);
end

function NotifyUserAboutSolution(solution)
    fprintf('VI: Result: a = %s, b = %f Obj. = %f.\n', Vec2Str(solution.a), solution.b, solution.objective);
end

function NotifyUserBetterSolutionFound()
    disp('VI: Better solution found.');
end
