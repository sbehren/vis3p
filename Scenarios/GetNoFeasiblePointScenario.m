function scenario = GetNoFeasiblePointScenario()
    scenario = GetStandardScenario();
    scenario.name = 'feasibility';

    scenario.set_objective_to_zero = true;
    scenario.constraints = InitConstraintPolynomials(scenario);
    scenario.q = false;
    scenario.truncation_order = 4;
    scenario.annotation_position = [-0.5, -1];
end

function constraints = InitConstraintPolynomials(scenario)
    x = scenario.vartable;
    constraints = [8*(x(1)) * (x(2)) - 1, 1/16 - (x(1) + 0.5)^2];
end
