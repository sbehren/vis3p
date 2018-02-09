function scenario = GetBoundedScenarioHighOrder()
    scenario = GetBoundedScenarioLowOrder();

    scenario.name = 'bounded_high';
    scenario.truncation_order = 5;
end
