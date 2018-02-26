function scenario = GetBoundedScenarioHighOrder()
    scenario = scenariopack.GetBoundedScenarioLowOrder();

    scenario.name = 'bounded_high';
    scenario.truncation_order = 5;
end
