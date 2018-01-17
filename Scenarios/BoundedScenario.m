function setup = BoundedScenario()
    num_vars = 2;
    fundamental_directions = GiveFundamentalDirections();

    setup = Setup(num_vars, fundamental_directions);
    setup.constraints = InitConstraintPolynomials(setup);
    setup.q = [0.4; -0.5];
    setup.min_order = 4;
    setup.max_order = setup.min_order;
end

function constraints = InitConstraintPolynomials(setup)
    x = setup.vartable;
    constraints = [1 - x(1)^2 - x(2)^2, x(1) + x(2)^3];
    %constraints = [x(1) - x(2), 1 - x(1)^2 - x(2)^2];
    %constraints = 1 - x(1)^2 - x(2)^2;
end

function fundamental_directions = GiveFundamentalDirections()
    %fundamental_directions = {[1; 0], [-1; 0], [0; 1], [0; -1]};
    fundamental_directions = {[0; -1]};
end
