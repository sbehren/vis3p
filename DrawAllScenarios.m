function DrawAllScenarios()
    saved_result = DrawIndependentScenarios();
    DrawDependentScenario(saved_result);
end

function saved_result = DrawIndependentScenarios()
    independent_setups = {GetBoundedScenarioLowOrder(), GetBoundedScenarioHighOrder(), GetUnboundedScenario(), GetNoFeasiblePointScenario()};

    for i = 1:length(independent_setups)
        setup = independent_setups{i};
        result = RunFullDisjunction(setup);
        if strcmp(setup.name, 'feasibility')
            saved_result = result;
        end
        DrawResults(setup, result);
    end
end

function DrawDependentScenario(result)
    dependent_setup = GetReoptimizeScenario();
    dependent_setup.fixed_normal = result.a;
    result = RunFullDisjunction(dependent_setup);
    DrawResults(dependent_setup, result);
end
