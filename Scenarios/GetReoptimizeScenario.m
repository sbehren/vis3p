function scenario = GetReoptimizeScenario()
    scenario = GetNoFeasiblePointScenario();
    scenario.name = 'reoptimize';

    scenario.normal_is_fixed = true;
    scenario.q = false;
end
