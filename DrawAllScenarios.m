function DrawAllScenarios()

    %all_scenarios = {GetBoundedScenarioLowOrder};
    all_scenarios = {GetBoundedScenarioLowOrder(), GetBoundedScenarioHighOrder(), GetUnboundedScenario(), GetNoFeasiblePointScenario(), GetReoptimizeScenario()};
    fixed_normal = NaN;

    for i = 1:length(all_scenarios)
        scenario = all_scenarios{i};

        if strcmp(scenario.name, 'reoptimize')
            AssertScenariosInRightOrder(fixed_normal);
            scenario.fixed_normal = fixed_normal;
        end

        scenario.RunFullDisjunction();

        if strcmp(scenario.name, 'feasibility')
            fixed_normal = scenario.a;
        end

        DrawScenario(scenario);
        LogScenario(scenario);
    end
end

function AssertScenariosInRightOrder(fixed_normal)
   assert(~ any(isnan(fixed_normal)), 'VI: Error. Need fixed normal for reoptimize scenario.');
end
