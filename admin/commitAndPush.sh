. ./admin/defs.sh

./admin/commit.sh $1 && pushLaunchpad || error
pushSubversion || error
