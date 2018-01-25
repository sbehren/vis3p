function DrawAllScenarios()

    all_setups = {GetBoundedScenarioLowOrder};
    %all_setups = {GetBoundedScenarioLowOrder(), GetBoundedScenarioHighOrder(), GetUnboundedScenario(), GetNoFeasiblePointScenario(), GetReoptimizeScenario()};
    fixed_normal = NaN;

    for i = 1:length(all_setups)
        setup = all_setups{i};

        if strcmp(setup.name, 'reoptimize')
            AssertSetupsInRightOrder(fixed_normal);
            setup.fixed_normal = fixed_normal;
        end

        result = RunFullDisjunction(setup);

        if strcmp(setup.name, 'feasibility')
            fixed_normal = result.a;
        end

        DrawResults(setup, result);
        LogSetupAndResult(setup, result);
    end
end

function AssertSetupsInRightOrder(fixed_normal)
   assert(~ any(isnan(fixed_normal)), 'VI: Error. Need fixed normal for reoptimize scenario.');
end

