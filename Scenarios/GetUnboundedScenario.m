function scenario = GetUnboundedScenario()
    scenario = GetStandardScenario();
    scenario.name = 'unbounded';

    scenario.constraints = InitConstraintPolynomials(scenario);
    scenario.q = [0.25; 0.5];
    scenario.truncation_order = 5;
end

function constraints = InitConstraintPolynomials(scenario)
    x = scenario.vartable;
    constraints = [x(2) - x(1)^2, x(2)^2 - x(1)];
end
