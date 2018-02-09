function SolveAndDraw(obj)
    RunDisjunctionIfNotDisabled(obj);
    obj.Draw();
    obj.Log();
end

function RunDisjunctionIfNotDisabled(obj)
    persistent fixed_normal;

    if obj.enable_hierarchy
        obj = SupplyFixedNormalIfNecessary(obj, fixed_normal);
        obj.RunFullDisjunction();
        fixed_normal = SaveFixedNormalIfNecessary(obj, fixed_normal);
    end
end

function scenario = SupplyFixedNormalIfNecessary(scenario, fixed_normal)
    if strcmp(scenario.name, 'reoptimize')
        assert(~ isempty(fixed_normal), 'VI: Error. Need fixed normal for reoptimize scenario.');
        scenario.fixed_normal = fixed_normal;
    end
end

function fixed_normal = SaveFixedNormalIfNecessary(scenario, fixed_normal)
    if strcmp(scenario.name, 'feasibility')
        fixed_normal = scenario.a;
    end
end
