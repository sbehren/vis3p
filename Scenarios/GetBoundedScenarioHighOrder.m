function setup = GetBoundedScenarioHighOrder()
    setup = GetStandardSetup();
    setup.name = 'bounded-high';

    setup.constraints = InitConstraintPolynomials(setup);
    setup.q = [0.4; -0.5];
    setup.truncation_order = 5;
end

function constraints = InitConstraintPolynomials(setup)
    x = setup.vartable;
    constraints = [1 - x(1)^2 - x(2)^2, x(1) + x(2)^3];
end
