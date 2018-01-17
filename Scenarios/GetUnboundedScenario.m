function setup = GetUnboundedScenario()
    setup = GetStandardSetup();

    setup.constraints = InitConstraintPolynomials(setup);
    setup.q = [0.25; 0.5];
    setup.min_order = 4;
    setup.max_order = setup.min_order;
end

function constraints = InitConstraintPolynomials(setup)
    x = setup.vartable;
    constraints = [x(2) - x(1)^2, x(2)^2 - x(1)];
end
