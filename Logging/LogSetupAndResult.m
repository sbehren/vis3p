function LogSetupAndResult(setup, result)
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
        a_info = ['a(' num2str(i) ') = ' Float2Str(a(i))];
        fwriteln(file, a_info);
    end

    b = result.b;
    b_info = ['b = ' Float2Str(b)];
    fwriteln(file, b_info);
end

function fwriteln(file, str)
    fprintf(file, '%s\n', str);
end
