function ValidInequalities()
    setup = GetUnboundedScenario();

    valid_ineqs = RunFullDisjunction(setup);

    DrawResults(setup, valid_ineqs);
end
