function RunFullDisjunction(obj)
    obj = ComputeOneValidInequality(obj);
    NotifyUserAboutSolution(obj);
end

function scenario = ComputeOneValidInequality(scenario)
    NotifyUserStartingFullDisjunction();

    fun_dirs = scenario.fundamental_directions;

    for fun_dir_index = 1:length(fun_dirs)
        NotifyUserStartingSosProgram(scenario, fun_dir_index);
        candidate = SolveOneFundamentalDirection(scenario, fun_dir_index);
        NotifyUserAboutSolution(candidate);
        scenario = CompareCurrentWithCandidate(scenario, candidate);
    end
    NotifyUserSolvedSosProgram(scenario);
end

function scenario = CompareCurrentWithCandidate(scenario, candidate)
    if candidate.solved && scenario.objective > candidate.objective
        NotifyUserBetterSolutionFound();
        scenario.objective = candidate.objective;
        scenario.a = candidate.a;
        scenario.b = candidate.b;
    end
end

function NotifyUserStartingFullDisjunction()
    fprintf('\n\n************************************\n');
    fprintf('VI: Starting full disjunction.\n');
end

function NotifyUserStartingSosProgram(scenario, fun_dir_index)
    fprintf('\n\nVI: ***** Setting up new sos program. *****\n');
    fprintf('VI: Scenario name is "%s".\n', scenario.name);

    num_fun_dirs = length(scenario.fundamental_directions);
    fprintf('VI: Starting disjunction %d of %d (truncation order k = %d).\n', fun_dir_index, num_fun_dirs, scenario.truncation_order);
end

function NotifyUserSolvedSosProgram(scenario)
    fprintf('VI: Done for M[k] with k = %d.\n', scenario.truncation_order);
end

function NotifyUserAboutSolution(solution)
    fprintf('VI: Result: a = %s, b = %f, scenario. val. = %f.\n', Vec2Str(solution.a), solution.b, solution.objective);
end

function NotifyUserBetterSolutionFound()
    disp('VI: Incumbent solution was updated.');
end
