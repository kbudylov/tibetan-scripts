LIB=pecha
NAME=PechaCreation
EGG_NAME=$NAME
BZR='lp:~oubiwann/adytum-collection/Projects'
SVN='svn+https://adytum.svn.sourceforge.net/svnroot/adytum/Projects/PechaCreation/trunk'
FLAG='skip_tests'
MSG=commit-msg
export PYTHONPATH=.:./test:$PYTHONPATH

function getDiff {
    bzr diff $1 | \
        egrep '^\+' | \
        sed -e 's/^\+//g'| \
        egrep -v "^\+\+ ChangeLog"
}

function abort {
    echo "*** Aborting rest of process! ***"
    exit 1
}

function error {
    echo "There was an error committing/pushing; temp files preserved."
    abort
}

function cleanup {
    echo "Cleaning up temporary files ..."
    rm -rf $MSG _trial_temp test.out .DS_Store CHECK_THIS_BEFORE_UPLOAD.txt
    echo "Done."
}

function localCommit {
    echo "Committing locally ..."
    bzr commit --local --file $MSG
}

function pushSucceed {
    echo "Push succeeded."
}

function pushLaunchpad {
    echo "Pushing to Launchpad now ($BZR) ..."
    bzr push $BZR && pushSucceed
    cleanup
}

function pushGoogle {
    echo "Pushing to Google Code (Subversion) now ..."
    bzr push $SVN
}

function buildSucceed {
    echo "Build succeeded."
    echo "Cleaning up files ..."
    ./admin/clean.sh
    echo "Done."
    echo
}
