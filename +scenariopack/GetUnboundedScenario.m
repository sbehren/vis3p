function scenario = GetUnboundedScenario()
    scenario = scenariopack.GetStandardScenario();
    scenario.name = 'unbounded';
    scenario.choice_obj_fun = scenariopack.Objective.distance;

    scenario.constraints = InitConstraintPolynomials(scenario);
    scenario.q = [0.25; 0.5];
    scenario.truncation_order = 4;
    scenario.annotation_position = [0, 1];
end

function constraints = InitConstraintPolynomials(scenario)
    x = scenario.vartable;
    constraints = [x(2) - x(1)^2, x(2)^2 - x(1)];
end
