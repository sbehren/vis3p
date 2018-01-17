function ValidInequalities()
    setup = BoundedScenario();

    valid_ineqs = RunFullDisjunction(setup);

    DrawResults(setup, valid_ineqs);
end
