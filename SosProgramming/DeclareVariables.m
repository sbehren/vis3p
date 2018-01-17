function [decision_vars, sos_program] = DeclareVariables(setup, order, sos_program)
    [decision_vars, sos_program] = DeclareHyperplaneVariables(setup, sos_program);
    [decision_vars, sos_program] = DeclareConstraintVariables(setup, order, decision_vars, sos_program);
end

function [decision_vars, sos_program] = DeclareHyperplaneVariables(setup, sos_program)
    a = sym('a', [setup.num_vars, 1]);
    syms b;

    sos_program = sosdecvar(sos_program, a);
    sos_program = sosdecvar(sos_program, b);

    decision_vars.a = a;
    decision_vars.b = b;
end

function [decision_vars, sos_program] = DeclareConstraintVariables(setup, order, decision_vars, sos_program)
    sigma_degrees = GetSigmaDegrees(setup, order);

    for i = 1:length(sigma_degrees)
        sigma_degree = sigma_degrees(i);
        [decision_vars.sigma(i), sos_program] = DeclareDenseSosPoly(setup.vartable, sigma_degree, sos_program);
    end

    NotifyUser(sigma_degree);

    function sigma_degrees = GetSigmaDegrees(setup, order)
        sigma_degrees = NaN * ones(length(setup.constraints));
        constraints = setup.constraints;

        for j = 1:length(constraints)
            g = constraints(j);
            deg = GetDegree(g);
            % Let k = truncation order. Then we require deg(sigma_j g_j) <= k.
            sigma_degrees(j) = RoundDownToEven(order - deg); 
        end
    end
end

function [dense_sos_poly, sos_program] = DeclareDenseSosPoly(vartable, degree, sos_program)
    assert(mod(degree, 2) == 0, 'Degree of sos poly needs to be even.')
    if degree < 0
        dense_sos_poly = 0;
    elseif degree == 0
        dense_sos_poly = 1;
    else
        monomials_vec = monomials( vartable, 0: degree );
        [sos_program, dense_sos_poly] = sossosvar(sos_program, monomials_vec);
    end
end

function degree = GetDegree(poly)
    degree = feval(symengine, 'degree', poly);
end

function result = RoundDownToEven(n)
    result = floor(n/2)*2;
end

function NotifyUser(sigma_degrees)
    disp(['VI: Created sos polynomial of degree(s) ', num2str(sigma_degrees)]);
end
