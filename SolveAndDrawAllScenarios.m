function SolveAndDrawAllScenarios()

    all_scenarios = GetAllScenarios();

    for i = 1:length(all_scenarios)
        scenario = all_scenarios{i};
        scenario.SolveAndDraw();
    end
end

function all_scenarios = GetAllScenarios()
    all_scenarios = {scenariopack.GetBoundedScenarioLowOrder(), scenariopack.GetBoundedScenarioHighOrder(), scenariopack.GetUnboundedScenario(), scenariopack.GetNoFeasiblePointScenario(), scenariopack.GetReoptimizeScenario()};
end
