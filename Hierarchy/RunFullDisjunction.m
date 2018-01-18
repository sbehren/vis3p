function valid_ineqs = RunFullDisjunction(setup)
    valid_ineqs = [];
    for order = setup.min_order:setup.max_order
        NotifyUserStartingHierarchy(order);

        best = ComputeOneValidInequality(setup, order);
        valid_ineqs = StoreValidIneq(best, order, valid_ineqs);

        NotifyUserAboutSolution(best);
    end
end

function best = ComputeOneValidInequality(setup, order)
    best = InitBestSolution();

    fun_dirs = setup.fundamental_directions;

    for fun_dir_index = 1:length(fun_dirs)
        solution = SolveOneLevel(setup, order, fun_dir_index);
        NotifyUserAboutSolution(solution);
        best = CompareBestWithCurrent(best, solution);
    end
    best.InitLinearFunction(setup.vartable);
    NotifyUserOneLevelOfHierarchySolved(order);
end

function best = InitBestSolution()
    best = Result();
end

function best = CompareBestWithCurrent(best, solution)
    if solution.solved && best.objective > solution.objective
        disp('VI: Better solution found.');
        best.objective = solution.objective;
        best.a = solution.a;
        best.b = solution.b;
    end
end

function NotifyUserStartingHierarchy(order)
    fprintf('\n\n************************************\n');
    fprintf('VI: Starting k = %dth truncation order.\n', order);
end

function NotifyUserOneLevelOfHierarchySolved(order)
    fprintf('VI: Done for M[k] with k = %d.\n', order);
end

function NotifyUserAboutSolution(solution)
    fprintf('VI: Result: a = (%f, %f), b = %f Obj. = %f.\n', solution.a(1), solution.a(2), solution.b, solution.objective);
end

function valid_ineqs = StoreValidIneq(best, order, valid_ineqs)
    valid_ineqs{order + 1} = best;
end
