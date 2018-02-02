function result = RunFullDisjunction(setup)
    result = ComputeOneValidInequality(setup);
    NotifyUserAboutSolution(result);
end

function best = ComputeOneValidInequality(setup)
    NotifyUserStartingFullDisjunction(setup);

    best = Result();

    fun_dirs = setup.fundamental_directions;

    for fun_dir_index = 1:length(fun_dirs)
        NotifyUserStartingSosProgram(setup, fun_dir_index);
        solution = SolveOneFundamentalDirection(setup, fun_dir_index);
        NotifyUserAboutSolution(solution);
        best = CompareBestWithCurrent(best, solution);
    end
    best.InitLinearFunction(setup.vartable);
    NotifyUserSolvedSosProgram(setup);
end

function best = CompareBestWithCurrent(best, solution)
    if solution.solved && best.objective > solution.objective
        NotifyUserBetterSolutionFound();
        best.objective = solution.objective;
        best.a = solution.a;
        best.b = solution.b;
    end
end

function NotifyUserStartingFullDisjunction(setup)
    fprintf('\n\n************************************\n');
    fprintf('VI: Starting full disjunction.\n');
end

function NotifyUserStartingSosProgram(setup, fun_dir_index)
    fprintf('\n\nVI: ***** Setting up new sos program. *****\n');
    fprintf('VI: Scenario name is "%s".\n', setup.name);

    num_fun_dirs = length(setup.fundamental_directions);
    fprintf('VI: Starting disjunction %d of %d (truncation order k = %d).\n', fun_dir_index, num_fun_dirs, setup.truncation_order);
end

function NotifyUserSolvedSosProgram(setup)
    fprintf('VI: Done for M[k] with k = %d.\n', setup.truncation_order);
end

function NotifyUserAboutSolution(solution)
    fprintf('VI: Result: a = %s, b = %f, obj. val. = %f.\n', Vec2Str(solution.a), solution.b, solution.objective);
end

function NotifyUserBetterSolutionFound()
    disp('VI: Incumbent solution was updated.');
end
