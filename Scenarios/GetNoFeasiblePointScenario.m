
function setup = GetNoFeasiblePointScenario()
    setup = GetStandardSetup();

    setup.is_feasibility_variant = true;
    setup.constraints = InitConstraintPolynomials(setup);
    setup.q = false;
    setup.truncation_order = 4;
end

function constraints = InitConstraintPolynomials(setup)
    x = setup.vartable;
    constraints = [x(1)*x(2) - 1, x(2)];
end
