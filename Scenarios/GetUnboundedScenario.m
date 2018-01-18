function setup = GetUnboundedScenario()
    setup = GetStandardSetup();
    setup.name = 'unbounded';

    setup.constraints = InitConstraintPolynomials(setup);
    setup.q = [0.25; 0.5];
    setup.truncation_order = 4;
end

function constraints = InitConstraintPolynomials(setup)
    x = setup.vartable;
    constraints = [x(2) - x(1)^2, x(2)^2 - x(1)];
end
