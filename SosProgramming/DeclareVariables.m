function [decision_vars, sos_program] = DeclareVariables(setup, order, sos_program)
    [decision_vars, sos_program] = DeclareHyperplaneVariables(setup, sos_program);
    [decision_vars, sos_program] = DeclareConstraintVariables(setup, order, decision_vars, sos_program);
end

function [decision_vars, sos_program] = DeclareHyperplaneVariables(setup, sos_program)
    if setup.normal_is_fixed
        a = setup.fixed_normal;
    else
        a = sym('a', [setup.num_vars, 1]);
        sos_program = sosdecvar(sos_program, a);
    end

    syms b;
    sos_program = sosdecvar(sos_program, b);

    decision_vars.a = a;
    decision_vars.b = b;
end

function [decision_vars, sos_program] = DeclareConstraintVariables(setup, order, decision_vars, sos_program)
    sigma_degs = GetSigmaDegrees(setup, order);

    NotifyUser(sigma_degs);
    for i = 1:length(sigma_degs)
        sigma_deg = sigma_degs(i);
        [decision_vars.sigma(i), sos_program] = DeclareDenseSosPoly(setup.vartable, sigma_deg, sos_program);
    end

end

function sigma_degs = GetSigmaDegrees(setup, order)
    sigma_degs = NaN * ones(length(setup.constraints), 1);
    constraints = setup.constraints;

    for j = 1:length(constraints)
        g = constraints(j);
        g_deg = GetDegree(g);
        sigma_degs(j) = GetSigmaDegree(g_deg, order);
    end
end

function sigma_deg = GetSigmaDegree(g_deg, order)
    if g_deg > order
       sigma_deg = -Inf;
    else
       % Let k = truncation order. Then we require deg(sigma_j g_j) <= k.
       sigma_deg = RoundDownToEven(order - g_deg); 
    end
end

function [dense_sos_poly, sos_program] = DeclareDenseSosPoly(vartable, deg, sos_program)
    if deg == -Inf
        dense_sos_poly = 0;
    elseif deg == 0
        dense_sos_poly = 1;
    elseif deg > 0
        assert(mod(deg, 2) == 0, 'Degree of nontrivial sos poly needs to be even.')
        monomials_vec = monomials( vartable, 0: deg );
        [sos_program, dense_sos_poly] = sossosvar(sos_program, monomials_vec);
    else
        error('VI: Illegal polynomial degree.');
    end
end

function deg = GetDegree(poly)
    deg = feval(symengine, 'degree', poly);
end

function result = RoundDownToEven(n)
    result = floor(n/2)*2;
end

function NotifyUser(sigma_degs)
    fprintf('VI: Created sos polynomial of degree(s) %s.', Vec2Str(sigma_degs));
end
