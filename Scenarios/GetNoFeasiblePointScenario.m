
function setup = GetNoFeasiblePointScenario()
    setup = GetStandardSetup();

    setup.feasibility_variant = true;
    setup.constraints = InitConstraintPolynomials(setup);
    setup.q = false;
    setup.min_order = 4;
    setup.max_order = setup.min_order;
end

function constraints = InitConstraintPolynomials(setup)
    x = setup.vartable;
    constraints = [x(1)*x(2) - 1, x(2)];
end
