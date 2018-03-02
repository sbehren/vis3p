function scenario = GetReoptimizeScenario()
    scenario = scenariopack.GetNoFeasiblePointScenario();
    scenario.name = 'reoptimize';

    scenario.fix_normal = true;
    scenario.fixed_normal = [- 1; 1];
end
