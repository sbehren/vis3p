function ValidInequalities()
    setup = GetBoundedScenario();

    valid_ineqs = RunFullDisjunction(setup);

    DrawResults(setup, valid_ineqs);
end
