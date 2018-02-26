function scenario = GetReoptimizeScenario()
    scenario = scenariopack.GetNoFeasiblePointScenario();
    scenario.name = 'reoptimize';
    scenario.choice_obj_fun = scenariopack.Objective.b_only;

    scenario.fix_normal = true;
end
