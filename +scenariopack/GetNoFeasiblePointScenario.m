function scenario = GetNoFeasiblePointScenario()
    scenario = scenariopack.GetStandardScenario();
    scenario.name = 'feasibility';

    scenario.choice_obj_fun = scenariopack.Objective.zero;
    scenario.constraints = InitConstraintPolynomials(scenario);
    scenario.truncation_order = 4;
    scenario.annotation_position = [-0.5, -1];
end

function constraints = InitConstraintPolynomials(scenario)
    x = scenario.vartable;
    constraints = [8*(x(1)) * (x(2)) - 1, 1/16 - (x(1) + 0.5)^2];
end
