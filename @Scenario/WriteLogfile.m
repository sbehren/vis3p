function WriteLogfile(obj)
    filename = obj.GetLogfileName;
    file = fopen(filename, 'w');

    WriteTimeStamp(file);
    WriteGitStatus(file);

    WriteSetupInfo(file, obj);
    WriteSolutionInfo(file, obj);

    WriteFigureInfo(file, obj);
end

function WriteTimeStamp(file)
    time = datestr(now, 'yyyy-mm-dd_hh-MM-SS');
    info = ['Creation: ' time];
    fwriteln(file, info);
end

function WriteGitStatus(file)
    git_status = GetGitStatus();
    fwriteln(file, git_status);

    git_revision = GetGitRevison();
    revision_info = ['Git revision: ' git_revision];
    fwriteln(file, revision_info);
end

function git_status = GetGitStatus()
    changed_files_present = CheckChangesInGit();
    if changed_files_present 
        git_status = 'WARNING: Uncommitted changes.';
    else
        git_status = 'Directory clean, no uncommitted changes present.';
    end
    git_status = ['Git status: ' git_status];
end

function WriteSolutionInfo(file, scenario)
    a = scenario.a;
    for i = 1:length(a)
        a_desc = ['a(' num2str(i) ')'];
        WriteNumericalScalar(file, a(i), a_desc);
    end

    WriteNumericalVector(file, scenario.a, 'a');
    WriteNumericalScalar(file, scenario.b, 'b');
    WriteNumericalScalar(file, scenario.objective, 'Objective value');
end

function WriteSetupInfo(file, scenario)
    WriteNumericalScalar(file, scenario.truncation_order, 'Truncation order k');
    WriteNumericalVector(file, scenario.q, 'Feasible point q');
    WriteConstraints(file, scenario);
end

function WriteConstraints(file, scenario)
    constraints = scenario.GetConstraintStrings();
    len = length(constraints);
    for i = 1:len
        constraint_str = ['h(' num2str(i) ') = '];
        fwrite(file, constraint_str);
    end
end

function WriteFigureInfo(file, scenario)
    filename = scenario.GetFigureName();
    info_filename = ['Filename of figure: ' filename];
    fwriteln(file, info_filename);

    hash = scenario.GetFigureHash();
    hash_info = ['SHA-256 value of figure: ' hash];
    fwriteln(file, hash_info);
end

function WriteNumericalScalar(file, value, description)
    output_str = [description ' = ' Float2Str(value)];
    fwriteln(file, output_str);
end

function WriteNumericalVector(file, vec, description)
    for i = 1:length(vec)
        rolled_out_desc = [description '(' num2str(i) ')'];
        value = vec(i);
        WriteNumericalScalar(file, value, rolled_out_desc);
    end

end
