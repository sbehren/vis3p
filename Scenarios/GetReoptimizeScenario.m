function scenario = GetReoptimizeScenario()
    scenario = GetStandardScenario();
    scenario.name = 'reoptimize';

    scenario.is_feasibility_variant = true;
    scenario.normal_is_fixed = true;
    scenario.constraints = InitConstraintPolynomials(scenario);
    scenario.q = false;
    scenario.truncation_order = 5;
end

function constraints = InitConstraintPolynomials(scenario)
    x = scenario.vartable;
    constraints = [x(2) - x(1)^2, x(2) - x(1)];
end
