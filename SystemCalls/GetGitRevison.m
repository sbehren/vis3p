function git_revision = GetGitRevison(obj)
    [errorcode, git_revision_dirty] = system('git rev-parse HEAD');
    assert(errorcode == 0, 'VI: Could not get revision info in system call to git.');
    git_revision = deblank(git_revision_dirty);
end
