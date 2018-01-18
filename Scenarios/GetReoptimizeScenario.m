function setup = GetNoReoptimizeScenario()
    setup = GetStandardSetup();
    setup.name = 'reoptimize';

    setup.normal_is_fixed = true;
    setup.constraints = InitConstraintPolynomials(setup);
    setup.q = false;
    setup.truncation_order = 4;
end

function constraints = InitConstraintPolynomials(setup)
    x = setup.vartable;
    constraints = [x(2) - x(1)^2, x(2) - x(1)];
end
