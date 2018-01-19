function setup = GetBoundedScenarioLowOrder()
    setup = GetStandardSetup();
    setup.name = 'bounded_low';

    setup.constraints = InitConstraintPolynomials(setup);
    setup.q = [0.4; -0.5];
    setup.truncation_order = 2;
end

function constraints = InitConstraintPolynomials(setup)
    x = setup.vartable;
    constraints = [1 - x(1)^2 - x(2)^2, x(1) + x(2)^3];
end
