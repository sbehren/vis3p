function SolveAndDrawAllScenarios()

    all_scenarios = GetAllScenarios();

    for i = 1:length(all_scenarios)
        scenario = all_scenarios{i};
        SolveAndDraw(scenario);
    end
end

function all_scenarios = GetAllScenarios()
    all_scenarios = {GetBoundedScenarioLowOrder(), GetBoundedScenarioHighOrder(), GetUnboundedScenario(), GetNoFeasiblePointScenario(), GetReoptimizeScenario()};
end

function SolveAndDraw(scenario)
    persistent fixed_normal;

    scenario = SupplyFixedNormalIfNecessary(scenario, fixed_normal);

    scenario.RunFullDisjunction();

    fixed_normal = SaveFixedNormalIfNecessary(scenario, fixed_normal);

    scenario.Draw();
    scenario.Log();
end

function scenario = SupplyFixedNormalIfNecessary(scenario, fixed_normal)
    if strcmp(scenario.name, 'reoptimize')
        assert(~ isempty(fixed_normal), 'VI: Error. Need fixed normal for reoptimize scenario.');
        scenario.fixed_normal = fixed_normal;
    end
end

function fixed_normal = SaveFixedNormalIfNecessary(scenario, fixed_normal)
    if strcmp(scenario.name, 'feasibility')
        fixed_normal = scenario.a;
    end
end
