function git_revision = GetGitRevison(obj)
    [errorcode, git_revision] = system('git rev-parse HEAD');
    assert(errorcode == 0, 'VI: Could not get revision info in system call to git.');
end
