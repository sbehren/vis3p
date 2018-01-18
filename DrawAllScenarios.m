function DrawAllScenarios()
    unrelated_setups = {GetBoundedScenario()};
    %unrelated_setups = {GetBoundedScenario(), GetUnboundedScenario(), GetNoFeasiblePointScenario()};

    for i = 1:length(unrelated_setups)
        setup = unrelated_setups{i};
        result = RunFullDisjunction(setup);
        DrawResults(setup, result);
    end
end
