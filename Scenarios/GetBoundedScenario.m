function setup = GetBoundedScenario()
    setup = GetStandardSetup();

    setup.feasibility_variant = true;
    setup.constraints = InitConstraintPolynomials(setup);
    setup.q = [0.4; -0.5];
    setup.min_order = 4;
    setup.max_order = setup.min_order;
end

function constraints = InitConstraintPolynomials(setup)
    x = setup.vartable;
    constraints = [1 - x(1)^2 - x(2)^2, x(1) + x(2)^3];
end
