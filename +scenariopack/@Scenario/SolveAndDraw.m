function SolveAndDraw(obj)
    RunDisjunctionIfNotDisabled(obj);
    obj.Draw();
    obj.Log();
end

function RunDisjunctionIfNotDisabled(obj)
    if obj.enable_hierarchy
        obj.RunFullDisjunction();
    end
end
