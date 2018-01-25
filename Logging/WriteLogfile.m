function WriteLogfile(setup, result)
    filename = setup.GetLogfileName;
    file = fopen(filename, 'w');

    WriteTimeStamp(file);
    WriteGitStatus(file);

    WriteFigureInfo(file, setup);
    WriteSolutionInfo(file, result)
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
        git_status = 'Directory clean: no uncommitted changes.';
    end
    git_status = ['Git status: ' git_status];
end

function WriteFigureInfo(file, setup)
    filename = setup.GetFigureName();
    info_filename = ['Filename of figure: ' filename];
    fwriteln(file, info_filename);

    hash = GetFileHash(filename);
    hash_info = ['SHA-256 value of figure: ' hash];
    fwriteln(file, hash_info);
end

function WriteSolutionInfo(file, result)
    a = result.a;
    for i = 1:length(a)
        a_desc = ['a(' num2str(i) ')'];
        WriteNumericalValue(file, a(i), a_desc);
    end

    WriteNumericalValue(file, result.b, 'b');

    WriteNumericalValue(file, result.objective, 'Objective value');
end

function WriteNumericalValue(file, value, description)
    output_str = [description ' = ' Float2Str(value)];
    fwriteln(file, output_str);
end

function fwriteln(file, str)
    fprintf(file, '%s\n', str);
end
