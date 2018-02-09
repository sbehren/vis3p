function scenario = GetBoundedScenarioLowOrder()
    scenario = GetStandardScenario();
    scenario.name = 'bounded_low';

    scenario.constraints = InitConstraintPolynomials(scenario);
    scenario.q = [0.4; -0.5];
    scenario.truncation_order = 2;

    scenario.annotation_position = [0.5, 0];
end

function constraints = InitConstraintPolynomials(scenario)
    x = scenario.vartable;
    constraints = [1 - x(1)^2 - x(2)^2, x(1) + x(2)^3];
end
