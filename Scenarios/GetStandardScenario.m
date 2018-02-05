function scenario = GetStandardScenario()
    num_vars = 2;
    fundamental_directions = GetStandardFundamentalDirections();
    scenario = Scenario(num_vars, fundamental_directions);
end

function fundamental_directions = GetStandardFundamentalDirections()
    fundamental_directions = {[1; 0], [-1; 0], [0; 1], [0; -1]};
    %fundamental_directions = {[0; -1]}; %standard test
end