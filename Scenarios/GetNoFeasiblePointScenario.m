function setup = GetNoFeasiblePointScenario()
    setup = GetStandardSetup();
    setup.name = 'feasibility';

    setup.is_feasibility_variant = true;
    setup.constraints = InitConstraintPolynomials(setup);
    setup.q = false;
    setup.truncation_order = 4;
end

function constraints = InitConstraintPolynomials(setup)
    x = setup.vartable;
    constraints = [8*(x(1)) * (x(2)) - 1, 1/16 - (x(1) + 0.5)^2];
end
